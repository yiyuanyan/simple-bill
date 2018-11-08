//
//  RegisterView.h
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/8.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterView : UIView
@property(nonatomic, strong) UITextField *userName;
@property(nonatomic, strong) UITextField *userPwd;
@property(nonatomic, strong) UITextField *confirmPwd;
//注册按钮
@property(nonatomic, strong) UIButton *regButton;
@end

NS_ASSUME_NONNULL_END
