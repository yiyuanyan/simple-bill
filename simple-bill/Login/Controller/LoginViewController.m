//
//  LoginViewController.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/5.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    [self initWithLoginView];
    // Do any additional setup after loading the view.
}
- (void)initWithLoginView {
    LoginView *loginVC = [LoginView new];
    [self.view addSubview:loginVC];
    [loginVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.left.right.equalTo(self.view);
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
