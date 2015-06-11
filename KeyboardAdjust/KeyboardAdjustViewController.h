//
//  UIViewController+KeyboardAdjust.h
//  KeyboardAdjustDemo
//
//  Created by 7heaven on 15/6/11.
//  Copyright (c) 2015年 sevenheaven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(int, KeyboardAdjust){
    KeyboardAdjustNone = 0,
    KeyboardAdjustScaling = 1,
    KeyboardAdjustAlignBottom = 2,
    KeyboardAdjustScrolling = 3
};

@interface KeyboardAdjustViewController : UIViewController{
    
}

@property (nonatomic) KeyboardAdjust keyboardAdjustStyle;

@end
