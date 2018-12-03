//
//  AccountsTopView.h
//  simple-bill
//
//  Created by 何建新 on 2018/11/27.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AccountsTopView : UIView
@property(nonatomic, strong) UIView *buttonBackgroundView;
@property(nonatomic, strong) UIButton *expenditureBtn;  //支出Button
@property(nonatomic, strong) UIButton *incomeBtn;  //收入Button
@property(nonatomic, strong) UIButton *cancelBtn;  //取消按钮
@property(nonatomic, strong) UIView *markerLine;  //标注线
@end

NS_ASSUME_NONNULL_END
