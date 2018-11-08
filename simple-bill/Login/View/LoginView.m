//
//  LoginView.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/5.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initWithLoginView];
    }
    return self;
}
-(void)initWithLoginView {
    self.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    UIImageView *headIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    [self addSubview:headIcon];
    [headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineH(88));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(LineH(63));
    }];
    UIView *inputOrder = [UIView new];
    inputOrder.layer.borderColor = UICOLOR_FROM_HEX(0xd6d6d6).CGColor;
    inputOrder.layer.borderWidth = 1;
    inputOrder.layer.cornerRadius = 5;
    inputOrder.layer.masksToBounds = YES;
    [self addSubview:inputOrder];
    [inputOrder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(LineY(215));
        make.width.mas_equalTo(LineW(300));
        make.height.mas_equalTo(LineH(80));
        make.centerX.equalTo(self.mas_centerX);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UICOLOR_FROM_HEX(0xd6d6d6);
    [inputOrder addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputOrder);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(inputOrder.mas_centerY);
    }];
    
    self.userName = [UITextField new];
    self.userName.placeholder = @"请输入用户名或手机号码";
    //self.userName.backgroundColor = UICOLOR_RANDOM_COLOR();
    [inputOrder addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputOrder.mas_left).offset(LineX(56));
        make.right.equalTo(inputOrder.mas_right).offset(-LineX(20));
        make.top.equalTo(inputOrder.mas_top).offset(1);
        make.bottom.equalTo(lineView.mas_top).offset(0);
    }];
    UIImageView *userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user"]];
    [inputOrder addSubview:userIcon];
    [userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineW(14));
        make.left.equalTo(inputOrder.mas_left).offset(LineX(15));
        make.centerY.equalTo(self.userName.mas_centerY);
    }];
    
    //密码输入框
    self.userPwd = [UITextField new];
    self.userPwd.placeholder = @"请输入6位以上密码";
    self.userPwd.secureTextEntry = YES;
    [inputOrder addSubview:self.userPwd];
    [self.userPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.userName);
        make.top.equalTo(lineView.mas_bottom).offset(1);
        make.bottom.equalTo(inputOrder.mas_bottom).offset(-1);
    }];
    UIImageView *pwdIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd"]];
    [inputOrder addSubview:pwdIcon];
    [pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userIcon.mas_centerX);
        make.centerY.equalTo(self.userPwd.mas_centerY);
        make.height.mas_equalTo(LineW(17));
        make.width.mas_equalTo(LineW(14));
    }];
    //本地登录开关
    UIView *localBack = [UIView new];
    //localBack.backgroundColor = UICOLOR_RANDOM_COLOR();
    [self addSubview:localBack];
    [localBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputOrder.mas_bottom).offset(LineY(5));
        make.left.right.equalTo(inputOrder);
        make.height.mas_equalTo(LineH(25));
    }];
    
  
    self.localSwitch = [[UISwitch alloc] init];
    [self.localSwitch setOn:NO];
    self.localSwitch.transform = CGAffineTransformMakeScale( 0.7, 0.7);
    [localBack addSubview:self.localSwitch];
    [self.localSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(localBack.mas_right).offset(0);
        make.centerY.equalTo(localBack.mas_centerY);
    }];
   
    UILabel *localLabel = [UILabel new];
    localLabel.font = Font(10);
    localLabel.text = @"免注册本地登录";
    localLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    [localLabel sizeToFit];
    [localBack addSubview:localLabel];
    [localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.localSwitch.mas_left).offset(-LineX(5));
        
        make.centerY.equalTo(localBack.mas_centerY);
    }];
   
    //登录按钮
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 5;
    [self.loginButton setTitle:@"登  录 / 注  册" forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = Font(14);
    [self.loginButton setTitleColor:UICOLOR_FROM_HEX(0xffffff) forState:UIControlStateNormal];
    self.loginButton.backgroundColor = UICOLOR_FROM_HEX(0x4768f3);
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputOrder);
        make.height.mas_equalTo(LineH(40));
        make.centerX.equalTo(inputOrder.mas_centerX);
        make.top.equalTo(localBack.mas_bottom).offset(LineY(10));
    }];
    //立即注册
    self.regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.regButton setTitle:@"立即注册" forState:UIControlStateNormal];
    [self.regButton setTitleColor:UICOLOR_FROM_HEX(0x999999) forState:UIControlStateNormal];
    self.regButton.titleLabel.font = Font(12);
    [self addSubview:self.regButton];
    [self.regButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginButton.mas_left).offset(0);
        make.top.equalTo(self.loginButton.mas_bottom).offset(LineH(10));
    }];
    //忘记密码
    self.forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgetPasswordButton setTitleColor:UICOLOR_FROM_HEX(0x999999) forState:UIControlStateNormal];
    self.forgetPasswordButton.titleLabel.font = Font(12);
    [self addSubview:self.forgetPasswordButton];
    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginButton.mas_right).offset(0);
        make.top.equalTo(self.loginButton.mas_bottom).offset(LineH(10));
    }];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
