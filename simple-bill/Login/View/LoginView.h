//
//  LoginView.h
//  simple-bill
//
//  Created by 何建新 on 2018/11/5.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginView : UIView
@property(nonatomic, strong) UITextField *userName;
@property(nonatomic, strong) UITextField *userPwd;
//登录按钮
@property(nonatomic, strong) UIButton *loginButton;
//注册按钮
@property(nonatomic, strong) UIButton *regButton;
//忘记密码按钮
@property(nonatomic, strong) UIButton *forgetPasswordButton;
//本地登录开关
@property(nonatomic, strong) UISwitch *localSwitch;
@end

NS_ASSUME_NONNULL_END
