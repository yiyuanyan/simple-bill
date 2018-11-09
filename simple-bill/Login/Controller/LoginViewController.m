//
//  LoginViewController.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/5.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "BaseTabBarController.h"
#import "HttpTools.h"
#import "LoginView.h"
@interface LoginViewController ()
@property(nonatomic, strong) LoginView *loginVC;
@property(nonatomic, assign) BOOL localBOOL;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    [self initWithLoginView];
    [self loginAndRegisterButtonAction];
    // Do any additional setup after loading the view.
}
- (void)initWithLoginView {
    self.loginVC = [LoginView new];
    [self.view addSubview:self.loginVC];
    [self.loginVC mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.left.right.equalTo(self.view);
    }];
    
    
}
//登录注册页面按钮动作监听
- (void)loginAndRegisterButtonAction {
    @weakify(self);
    //登录按钮
    [[self.loginVC.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"点击登录按钮啦---%@",self.loginVC.userName.text);
        
        if(self.localBOOL == YES){
            //本地登录
            BaseTabBarController *tabbar = [BaseTabBarController new];
            [UserDefaults() setObject:@"yes" forKey:@"login"];
            [UserDefaults() setObject:@"yes" forKey:@"localLogin"];
            [UserDefaults() synchronize];
            [self.navigationController pushViewController:tabbar animated:YES];
            
        }else{
            //网络登录
            NSString *userPhone = self.loginVC.userName.text;
            NSString *userPwd = self.loginVC.userPwd.text;
            NSString *path = [NSString stringWithFormat:@"%@%@/%@",LOGIN_PATH,userPhone,userPwd];
            [HttpTools PostHttpDataWithUrlStr:path SuccessBlock:^(id  _Nonnull responseObject) {
                
                [MBProgressHUD showLoading:self.view];
                if([responseObject[@"status"] intValue] == 1){
                    NSDictionary *userInfo = responseObject[@"data"];
                    [UserDefaults() setObject:@"yes" forKey:@"login"];
                    [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"u_id"]] forKey:@"user_id"];
                    [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"user_phone"]] forKey:@"user_phone"];
                    [UserDefaults() setObject:[NSString stringWithFormat:@"%@",self.loginVC.userPwd] forKey:@"user_pwd"];
                    [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"user_token"]] forKey:@"user_token"];
                    [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"token_time_out"]] forKey:@"token_time_out"];
                    [UserDefaults() synchronize];
                    NSLog(@"%@",[UserDefaults() objectForKey:@"token_time_out"]);
                    [MBProgressHUD hideHUDForView:self.view];
                    BaseTabBarController *tabbar = [BaseTabBarController new];
                    [self.navigationController presentViewController:tabbar animated:NO completion:nil];
                }else{
                    [MBProgressHUD hideHUDForView:self.view];
                    [MBProgressHUD showMessage:[NSString stringWithFormat:@"%@",responseObject[@"msg"]] toView:self.view];
                }
                
            } FailedBlock:^(id  _Nonnull error) {
                NSLog(@"%@",error);
                [MBProgressHUD showMessage:@"登录失败" toView:self.view];
            }];
            
        }
    }];
    //本地登录开关
    [[self.loginVC.localSwitch rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        @strongify(self);
        self.localBOOL = !self.localBOOL;
        if(self.localBOOL == NO){
            NSLog(@"关闭了本地登录");
            self.loginVC.loginButton.backgroundColor = UICOLOR_FROM_HEX(0x4768f3);
            //self.loginVC.regButton.hidden = NO;
            self.loginVC.forgetPasswordButton.hidden = NO;
            [self.loginVC.loginButton setTitle:@"登  录 / 注  册" forState:UIControlStateNormal];
        }else{
            NSLog(@"开启了本地登录");
            self.loginVC.loginButton.backgroundColor = UICOLOR_FROM_HEX(0xeb6805);
            [self.loginVC.loginButton setTitle:@"登  录" forState:UIControlStateNormal];
            //隐藏注册和忘记密码按钮
            self.loginVC.regButton.hidden = YES;
            
        }
    }];
    
    //注册按钮
    [[self.loginVC.regButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        RegisterViewController *regVC = [RegisterViewController new];
        [self.navigationController pushViewController:regVC animated:YES];

    }];
    
    //忘记密码按钮
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
