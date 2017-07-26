//
//  BPBaseTabBarController.m
//  baseProgram
//
//  Created by iMac on 2017/7/24.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPBaseTabBarController.h"
#import "BPPersonalViewController.h"
#import "BPBaseNavigationController.h"
#import "BPNewListViewController.h"


@interface BPBaseTabBarController ()

@property(nonatomic,assign)NSInteger indexFlag;

@end

@implementation BPBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setupViewControllers];
    
}

-(void)setupViewControllers
{
    BPNewListViewController *newsListVC = [BPNewListViewController new];
    BPBaseNavigationController *nav = [[BPBaseNavigationController alloc]initWithRootViewController:newsListVC];
    UIImage *homeNorImage = [[UIImage imageNamed:@"homeSelected" ] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIImage *homeSelImage = [[UIImage imageNamed:@"home-1" ] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem =[[UITabBarItem alloc]initWithTitle:@"爆料" image:homeNorImage selectedImage:homeSelImage];
    
    BPPersonalViewController *personalVC = [BPPersonalViewController new];
    BPBaseNavigationController *nav1 = [[BPBaseNavigationController alloc]initWithRootViewController:personalVC];
    UIImage *personalNorImage = [[UIImage imageNamed:@"personalSelected" ] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIImage *personalSelImage = [[UIImage imageNamed:@"personal"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    nav1.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:personalNorImage selectedImage:personalSelImage];
    
    self.viewControllers = @[nav,nav1];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.tabBar.tintColor = GlobalGreenColor;
    self.selectedIndex = 0;
    self.indexFlag = 0;
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
    
}


// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
    self.indexFlag = index;
    
}

- (BOOL)shouldAutorotate
{
    return [self.selectedViewController shouldAutorotate];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return [self.selectedViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
}



@end
