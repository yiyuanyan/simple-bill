//
//  BaseTabBarController.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/8.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "BaseTabBarController.h"
#import "DetailedController.h"
#import "ChartController.h"
#import "AccountsController.h"
#import "DiscoveredController.h"
#import "MyController.h"
#import "BaseNavigationController.h"
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.delegate = self;
    UIView *view = [UIView new];
    view.backgroundColor = UICOLOR_FROM_HEX(0xfefefe);
    view.frame = self.tabBar.bounds;
    [[UITabBar appearance] insertSubview:view atIndex:0];
    self.tabBar.translucent = NO;
    //添加视图
    [self setupChildControllers];
}
- (void)setupChildControllers {
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"activity" rootViewControllerClass:[DetailedController class] tabbarTitle:@"明细"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"dynamic" rootViewControllerClass:[ChartController class] tabbarTitle:@"图表"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"addition" rootViewControllerClass:[AccountsController class] tabbarTitle:@"账单"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"coordinates" rootViewControllerClass:[DiscoveredController class] tabbarTitle:@"发现"];
    [self setupChildNavigationControllerWithClass:[BaseNavigationController class] tabbarImageName:@"addressbook" rootViewControllerClass:[MyController class] tabbarTitle:@"我的"];
}
- (void)setupChildNavigationControllerWithClass:(Class)class tabbarImageName:(NSString *)name rootViewControllerClass:(Class)rootViewControllerClass tabbarTitle:(NSString *)title {
    UIViewController *rootVC = [[rootViewControllerClass alloc] init];
    UINavigationController *navVC = [[class alloc] initWithRootViewController:rootVC];
    navVC.tabBarItem.title = title;
    navVC.tabBarItem.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVC.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_select",name]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //navVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-5, 0, 2, 0);
    //[navVC.tabBarItem setTitlePositionAdjustment:UIOffsetMake(5, 5)];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = UICOLOR_FROM_HEX(0x747374);
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    [self addChildViewController:navVC];
    
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
