//
//  AppDelegate.m
//  CattleHorseClockProgram
//
//  Created by runingfish on 2025/6/2.
//

#import "AppDelegate.h"
#import "CHCPSlpashViewController.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[CHCPSlpashViewController new]];
    self.window.rootViewController = nav;
    return YES;
}
@end
