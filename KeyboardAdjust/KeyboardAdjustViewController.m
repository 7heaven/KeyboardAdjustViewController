//
//  KeyboardAdjustViewController.m
//  KeyboardAdjustDemo
//
//  Created by 7heaven on 15/6/11.
//  Copyright (c) 2015年 sevenheaven. All rights reserved.
//

#import "KeyboardAdjustViewController.h"

@interface KeyboardAdjustViewController(){
    CGFloat _intrinctContentHeight;
    CGFloat _originY;
    
    KeyboardAdjust _keyboardAdjustStyle;
}

@end

@implementation KeyboardAdjustViewController

//- (void) loadView{
//    
//    NSString *nibName = self.nibName;
//    
//    if(self.keyboardAdjustStyle != KeyboardAdjustNone){
//        if(!nibName || nibName.length == 0){
//            nibName = NSStringFromClass([self class]);
//        }
//        
//        self.view = [[UIScrollView alloc] initWithFrame:self.view.frame];
//        _intrinctContentHeight = self.view.frame.size.height;
//        _originY = self.view.frame.origin.y;
//        ((UIScrollView *) self.view).contentSize = self.view.frame.size;
//        ((UIScrollView *) self.view).delegate = self;
//        
//        NSString *xibPath = [[NSBundle mainBundle] pathForResource:nibName ofType:@"xib"];
//        
//        if(xibPath){
//            NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
//            
//            if(objects[0] && [objects[0] isKindOfClass:[UIView class]]){
//                
//                [objects[0] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//                
//                [self.view addSubview:objects[0]];
//            }
//        }
//        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
//                                       initWithTarget:self
//                                       action:@selector(dismissKeyboard)];
//        
//        [self.view addGestureRecognizer:tap];
//        
//    }
//}

- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    
    if(self.keyboardAdjustStyle != KeyboardAdjustNone){
        [self removeAllKeyboardNotifications];
        [self addKeyboardNotifications];
        
        if(![self.view isKindOfClass:[UIScrollView class]]){
            
            NSString *nibName = self.nibName;
            
            if(!nibName || nibName.length == 0){
                nibName = NSStringFromClass([self class]);
            }
            
            self.view = [[UIScrollView alloc] initWithFrame:self.view.frame];
            _intrinctContentHeight = self.view.frame.size.height;
            _originY = self.view.frame.origin.y;
            ((UIScrollView *) self.view).contentSize = self.view.frame.size;
//            ((UIScrollView *) self.view).delegate = self;
            
            NSString *xibPath = [[NSBundle mainBundle] pathForResource:nibName ofType:@"xib"];
            
            if(xibPath){
                NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
                
                if(objects[0] && [objects[0] isKindOfClass:[UIView class]]){
                    
                    [objects[0] setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
                    
                    [self.view addSubview:objects[0]];
                }
            }
            
        }
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(dismissKeyboard)];
        
        [self.view addGestureRecognizer:tap];
    }
}

- (void) dismissKeyboard{
    [self.view endEditing:YES];
}

- (void) setKeyboardAdjustStyle:(KeyboardAdjust)keyboardAdjustStyle{
    
    _keyboardAdjustStyle = keyboardAdjustStyle;
    
    if(self.isViewLoaded && keyboardAdjustStyle != KeyboardAdjustNone){
        [self removeAllKeyboardNotifications];
        [self addKeyboardNotifications];
    }
}

- (KeyboardAdjust) keyboardAdjustStyle{
    return _keyboardAdjustStyle;
}

- (void) removeAllKeyboardNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void) addKeyboardNotifications{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeFrame:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
//    _intrinctContentHeight = self.view.frame.size.height;
//    _originY = self.view.frame.origin.y;
    
    [UIView animateWithDuration:0.3f animations:^{
        switch(self.keyboardAdjustStyle){
            case KeyboardAdjustNone:
                break;
            case KeyboardAdjustScrolling:{
                if([self.view isKindOfClass:[UIScrollView class]]){
                    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrameBeginRect.size.height, 0.0);
                    ((UIScrollView *) self.view).contentInset = contentInsets;
                    ((UIScrollView *) self.view).scrollIndicatorInsets = contentInsets;
                    
                    NSLog(@"self.view.height:%.f contentHeight:%.f", self.view.frame.size.height, ((UIScrollView *) self.view).contentSize.height);
                }
                break;
            }
            case KeyboardAdjustAlignBottom:
                self.view.frame = CGRectMake(self.view.frame.origin.x, keyboardFrameBeginRect.origin.y - self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                break;
            case KeyboardAdjustScaling:
                self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, keyboardFrameBeginRect.origin.y - self.view.frame.origin.y);
                if([self.view isKindOfClass:[UIScrollView class]]){
                    ((UIScrollView *) self.view).contentSize = self.view.frame.size;
                }
                break;
        }
    }];
    
    if([self respondsToSelector:@selector(keyboardWillShowWithFrame:notification:)])[self keyboardWillShowWithFrame:keyboardFrameBeginRect notification:notification];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    if([self respondsToSelector:@selector(keyboardDidShowWithFrame:notification:)])[self keyboardDidShowWithFrame:keyboardFrameBeginRect notification:notification];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.3f animations:^{
        switch(self.keyboardAdjustStyle){
            case KeyboardAdjustNone:
                break;
            case KeyboardAdjustScrolling:{
                if([self.view isKindOfClass:[UIScrollView class]]){
                    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrameBeginRect.size.height, 0.0);
                    ((UIScrollView *) self.view).contentInset = contentInsets;
                    ((UIScrollView *) self.view).scrollIndicatorInsets = contentInsets;
                    
                    NSLog(@"self.view.height:%.f contentHeight:%.f", self.view.frame.size.height, ((UIScrollView *) self.view).contentSize.height);
                }
                break;
            }
            case KeyboardAdjustAlignBottom:
                self.view.frame = CGRectMake(self.view.frame.origin.x, keyboardFrameBeginRect.origin.y - self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
                break;
            case KeyboardAdjustScaling:
                self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, keyboardFrameBeginRect.origin.y - self.view.frame.origin.y);
                if([self.view isKindOfClass:[UIScrollView class]]){
                    ((UIScrollView *) self.view).contentSize = self.view.frame.size;
                }
                break;
        }
    }];
    if([self respondsToSelector:@selector(keyboardWillChangeFrame:notification:)])[self keyboardWillChangeFrame:keyboardFrameBeginRect notification:notification];
}

- (void)keyboardDidChangeFrame:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    if([self respondsToSelector:@selector(keyboardDidChangeFrame:notification:)])[self keyboardDidChangeFrame:keyboardFrameBeginRect notification:notification];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:0.3f animations:^{
        switch(self.keyboardAdjustStyle){
            case KeyboardAdjustNone:
                break;
            case KeyboardAdjustScrolling:{
                if([self.view isKindOfClass:[UIScrollView class]]){
                    //                UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardFrameBeginRect.size.height, 0.0);
                    ((UIScrollView *) self.view).contentInset = UIEdgeInsetsZero;
                    ((UIScrollView *) self.view).scrollIndicatorInsets = UIEdgeInsetsZero;
                    
                    NSLog(@"self.view.height:%.f contentHeight:%.f", self.view.frame.size.height, ((UIScrollView *) self.view).contentSize.height);
                }
                break;
            }
            case KeyboardAdjustAlignBottom:
                self.view.frame = CGRectMake(self.view.frame.origin.x, _originY, self.view.frame.size.width, self.view.frame.size.height);
                break;
            case KeyboardAdjustScaling:
                self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, _intrinctContentHeight);
                if([self.view isKindOfClass:[UIScrollView class]]){
                    ((UIScrollView *) self.view).contentSize = self.view.frame.size;
                }
                break;
        }
    }];
    
    if([self respondsToSelector:@selector(keyboardWillHideWithFrame:notification:)])[self keyboardWillHideWithFrame:keyboardFrameBeginRect notification:notification];
}

- (void)keyboardDidHide:(NSNotification *)notification {
    NSDictionary *keyboardInfo = [notification userInfo];
    NSValue *keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    if([self respondsToSelector:@selector(keyboardDidHideWithFrame:notification:)])[self keyboardDidHideWithFrame:keyboardFrameBeginRect notification:notification];
}

- (void) keyboardWillShowWithFrame:(CGRect) frame notification:(NSNotification *) notification{
    
}

- (void) keyboardDidShowWithFrame:(CGRect) frame notification:(NSNotification *) notification{
    
}

- (void) keyboardWillChangeFrame:(CGRect) frame notification:(NSNotification *) notification{
    
}

- (void) keyboardDidChangeFrame:(CGRect) frame notification:(NSNotification *) notification{
    
}

- (void) keyboardWillHideWithFrame:(CGRect) frame notification:(NSNotification *) notification{
    
}

- (void) keyboardDidHideWithFrame:(CGRect) frame notification:(NSNotification *) notification{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
