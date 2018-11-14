//
//  RegisterViewController.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/7.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterView.h"
#import "LoginAndRegisterModel.h"
#import "BaseTabBarController.h"
#import "HttpTools.h"
@interface RegisterViewController ()
@property(nonatomic, strong) RegisterView *regView;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"forback"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(forBack)];
    self.navigationItem.leftBarButtonItem = leftItem;
    [self initWithRegisterView];
    [self registerViewButtonAction];
}
- (void)initWithRegisterView{
    self.regView = [RegisterView new];
    [self.view addSubview:self.regView];
    [self.regView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(NAVIGATION_BAR_HEIGHT);
        make.bottom.left.right.equalTo(self.view);
    }];
}
-(void)forBack{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void) registerViewButtonAction{
    @weakify(self);
    [[self.regView.regButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"点击了注册按钮");
        NSString *mobileNumber = [NSString stringWithFormat:@"%@",self.regView.userName.text];
        if([self validateContactNumber:mobileNumber] == NO){
            
            [MBProgressHUD showMessage:@"手机号码格式不正确" toView:self.view];
            return;
        }
        NSString *pwd = [NSString stringWithFormat:@"%@",self.regView.userPwd.text];
        NSString *confirmPwd = [NSString stringWithFormat:@"%@",self.regView.confirmPwd.text];
        if(pwd.length < 6){
            NSLog(@"密码必须大于6位");
            [MBProgressHUD showMessage:@"密码必须大于6位" toView:self.view];
            return;
        }
        if(![pwd isEqualToString:confirmPwd]){
            NSLog(@"确认密码与密码不符");
            [MBProgressHUD showMessage:@"确认密码与密码不符" toView:self.view];
            return;
        }
        //提交注册信息
        NSString *path = [NSString stringWithFormat:@"%@%@/%@",REGISTER_PATH,mobileNumber,pwd];
        [self registerUserInfo:path];
    }];
}
- (void)registerUserInfo:(NSString *)path{
    [HttpTools PostHttpDataWithUrlStr:path SuccessBlock:^(id  _Nonnull responseObject) {
        if([responseObject[@"status"] intValue] == 1){
            [MBProgressHUD showMessage:@"注册成功" toView:self.view];
            NSDictionary *userInfo = responseObject[@"data"];
            [UserDefaults() setObject:@"yes" forKey:@"login"];
            [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"u_id"]] forKey:@"user_id"];
            [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"user_phone"]] forKey:@"user_phone"];
            [UserDefaults() setObject:[NSString stringWithFormat:@"%@",self.regView.userPwd.text] forKey:@"user_pwd"];
            [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"user_token"]] forKey:@"user_token"];
            [UserDefaults() setObject:[NSString stringWithFormat:@"%@",userInfo[@"token_time_out"]] forKey:@"token_time_out"];
            [UserDefaults() synchronize];
            BaseTabBarController *tabbar = [BaseTabBarController new];
            [self.navigationController presentViewController:tabbar animated:NO completion:nil];
            
        }
        if([responseObject[@"status"] intValue] == 0){
            [MBProgressHUD showMessage:@"用户已存在" toView:self.view];
        }
    } FailedBlock:^(id  _Nonnull error) {
        [MBProgressHUD showMessage:@"注册失败" toView:self.view];
    }];
}
//验证手机号码
- (BOOL)validateContactNumber:(NSString *)mobileNumber{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,175,176,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|7[56]|8[56])\\d{8}$";
    
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,177,180,189
     22         */
    NSString * CT = @"^1((33|53|77|8[09])[0-9]|349)\\d{7}$";
    
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    // NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    
    if(([regextestmobile evaluateWithObject:mobileNumber] == YES)
       || ([regextestcm evaluateWithObject:mobileNumber] == YES)
       || ([regextestct evaluateWithObject:mobileNumber] == YES)
       || ([regextestcu evaluateWithObject:mobileNumber] == YES)){
        return YES;
    }else{
        return NO;
    }
    
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
