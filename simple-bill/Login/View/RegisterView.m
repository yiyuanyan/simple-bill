//
//  RegisterView.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/8.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "RegisterView.h"

@implementation RegisterView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initWithRegisterView];
    }
    return self;
}
-(void)initWithRegisterView {
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
        make.height.mas_equalTo(LineH(120));
        make.centerX.equalTo(self.mas_centerX);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UICOLOR_FROM_HEX(0xd6d6d6);
    [inputOrder addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputOrder);
        make.height.mas_equalTo(1);
        make.top.equalTo(inputOrder.mas_top).offset(LineY(40));
        //make.centerY.equalTo(inputOrder.mas_centerY);
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
        make.height.mas_equalTo(LineH(40));
    }];
    UIImageView *pwdIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd"]];
    [inputOrder addSubview:pwdIcon];
    [pwdIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(userIcon.mas_centerX);
        make.centerY.equalTo(self.userPwd.mas_centerY);
        make.height.mas_equalTo(LineW(17));
        make.width.mas_equalTo(LineW(14));
    }];
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = UICOLOR_FROM_HEX(0xd6d6d6);
    [inputOrder addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputOrder);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(inputOrder.mas_bottom).offset(-LineY(40));
        //make.centerY.equalTo(inputOrder.mas_centerY);
    }];
    //确认密码
    self.confirmPwd = [UITextField new];
    self.confirmPwd.placeholder = @"请输入确认密码";
    self.confirmPwd.secureTextEntry = YES;
    [inputOrder addSubview:self.confirmPwd];
    [self.confirmPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.userPwd);
        make.height.mas_equalTo(LineH(40));
        make.top.equalTo(lineView2.mas_bottom).offset(1);
    }];
    UIImageView *pwdIcon2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd"]];
    [inputOrder addSubview:pwdIcon2];
    [pwdIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(pwdIcon.mas_centerX);
        make.centerY.equalTo(self.confirmPwd.mas_centerY);
        make.height.mas_equalTo(LineW(17));
        make.width.mas_equalTo(LineW(14));
    }];
    
    
    
    
    
    
    //注册按钮
    self.regButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.regButton.layer.masksToBounds = YES;
    self.regButton.layer.cornerRadius = 5;
    [self.regButton setTitle:@"注  册" forState:UIControlStateNormal];
    self.regButton.titleLabel.font = Font(14);
    [self.regButton setTitleColor:UICOLOR_FROM_HEX(0xffffff) forState:UIControlStateNormal];
    self.regButton.backgroundColor = UICOLOR_FROM_HEX(0x4768f3);
    [self addSubview:self.regButton];
    [self.regButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputOrder);
        make.height.mas_equalTo(LineH(40));
        make.centerX.equalTo(inputOrder.mas_centerX);
        make.top.equalTo(inputOrder.mas_bottom).offset(LineY(15));
    }];
    
    
    
}

@end
