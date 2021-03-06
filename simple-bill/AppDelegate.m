//
//  AppDelegate.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/8.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "BaseClass/BaseTabBarController.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIApplication *app = [UIApplication sharedApplication];
    //app.statusBarStyle = UIStatusBarStyleLightContent;
    app.statusBarStyle = UIStatusBarStyleDefault;
    app.statusBarHidden = NO;
    [self initIQKeyboardManager];
    [self initKeyWindow];
    return YES;
}

- (void)initKeyWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = UICOLOR_FROM_HEX(0xfefefe);
    LoginViewController *login = [LoginViewController new];
    BaseTabBarController *tabVC = [BaseTabBarController new];
    if(IsStrEmpty([UserDefaults() objectForKey:@"user_phone"]) && IsStrEmpty([UserDefaults() objectForKey:@"u_id"])){
        [UserDefaults() setObject:@"no" forKey:@"login"];
        [UserDefaults() synchronize];
    }
    if([[UserDefaults() objectForKey:@"login"] isEqualToString:@"yes"]){
        //本地登录
        if([[UserDefaults() objectForKey:@"localLogin"] isEqualToString:@"yse"]){
            self.window.rootViewController = tabVC;
        }else{
            //网络登录
            self.window.rootViewController = tabVC;
        }
        
    }else{
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:login];
        self.window.rootViewController = nav;
    }
    
    [self.window makeKeyAndVisible];
}
- (void)initIQKeyboardManager {
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    [manager setToolbarManageBehaviour:IQAutoToolbarByPosition];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
