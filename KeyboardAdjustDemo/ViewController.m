//
//  ViewController.m
//  KeyboardAdjust
//
//  Created by 7heaven on 15/6/11.
//  Copyright (c) 2015年 sevenheaven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 40)];
    
    [self.view addSubview:textField];
    
    UILabel *wholeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)];
    wholeLabel.numberOfLines = 0;
    [wholeLabel setFont:[UIFont systemFontOfSize:50.0f]];
    [wholeLabel setTextColor:[UIColor blackColor]];
    
    [wholeLabel setText:@"alfa, bravo, charlie, delta, echo, foxtrot, golf, hotel, india, juliet, kilo, lima, mike, november, oscar, papa, quebec, romeo, sierra, tango, uniform, victor, whiskey, xray, yankee, zulu"];
    
    [self.view addSubview:wholeLabel];
}

@end
