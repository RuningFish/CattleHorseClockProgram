//
//  CHCPSelectRootVC.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/3.
//

#import "CHCPSelectRootVC.h"
#import "CHCPHomeViewController.h"
#import "CHCPRecordViewController.h"
#import "CHCPSettingViewController.h"
@implementation CHCPSelectRootVC
+ (void)chcp_sleectRootViewController {
    UITabBarController *tabVC = [UITabBarController new];
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    CHCPHomeViewController *vc_1 = [CHCPHomeViewController new];
    vc_1.title = @"首页";
    UINavigationController *nav_1 = [[UINavigationController alloc] initWithRootViewController:vc_1];
    
    CHCPRecordViewController *vc_2 = [CHCPRecordViewController new];
    vc_2.title = @"记录";
    UINavigationController *nav_2 = [[UINavigationController alloc] initWithRootViewController:vc_2];
    
    CHCPSettingViewController *vc_3 = [CHCPSettingViewController new];
    vc_3.title = @"设置";
    UINavigationController *nav_3 = [[UINavigationController alloc] initWithRootViewController:vc_3];
    
    [viewControllers addObject:nav_1];
    [viewControllers addObject:nav_2];
    [viewControllers addObject:nav_3];
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    tabVC.viewControllers = viewControllers;
    keyWindow.rootViewController = tabVC;
}
@end
