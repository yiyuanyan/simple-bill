//
//  InputView.h
//  simple-bill
//
//  Created by 何建新 on 2018/12/4.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InputView : UIView
@property(nonatomic, strong)UIButton *cancelButton;  //取消按钮
@property(nonatomic, strong) UITextField *remarksField;  //备注Field
@property(nonatomic, strong) UITextField *moneyField;  //金额Field
@end

NS_ASSUME_NONNULL_END
