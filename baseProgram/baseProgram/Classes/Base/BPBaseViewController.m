//
//  BPBaseViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/23.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPBaseViewController.h"

@interface BPBaseViewController ()

@end

@implementation BPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

//不支持横屏设置三个方法
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}

@end
