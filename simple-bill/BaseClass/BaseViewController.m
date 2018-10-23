//
//  BaseViewController.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/9.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"简单记账";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:24],
       
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self setTopView];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0xfefefe);
}
- (void)setTopView {
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = UICOLOR_FROM_HEX(0xf9db61);
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT + 88);
    }];
    
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
