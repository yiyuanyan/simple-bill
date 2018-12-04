//
//  InputView.m
//  simple-bill
//
//  Created by 何建新 on 2018/12/4.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "InputView.h"
@interface InputView()
@property(nonatomic, strong) UIView *topInfoView;
@end
@implementation InputView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initInputViewUI];
    }
    return self;
}
- (void)initInputViewUI {
    self.backgroundColor = UICOLOR_FROM_HEX(0xfafafa);
    self.topInfoView = [UIView new];
    [self addSubview:self.topInfoView];
    [self.topInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(LineH(42));
    }];
    //分割线1
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = UICOLOR_FROM_HEX(0xc9c9c9);
    [self.topInfoView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.topInfoView);
        make.height.mas_equalTo(1);
    }];
    //分割线2
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = UICOLOR_FROM_HEX(0xc9c9c9);
    [self.topInfoView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.topInfoView);
        make.height.mas_equalTo(1);
    }];
    self.cancelButton = [UIButton new];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:UICOLOR_FROM_HEX(0x333333) forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = Font(14);
    [self.topInfoView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(40));
        make.height.mas_equalTo(LineH(25));
        make.centerY.equalTo(self.topInfoView.mas_centerY);
        make.right.equalTo(self.topInfoView.mas_right).offset(-15);
    }];
    UILabel *remarksLabel = [UILabel new];
    remarksLabel.text = @"备注:";
    remarksLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    remarksLabel.font = Font(12);
    [remarksLabel sizeToFit];
    [self.topInfoView addSubview:remarksLabel];
    [remarksLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.topInfoView.mas_centerY);
        make.left.equalTo(self.topInfoView.mas_left).offset(15);
    }];
    self.remarksField = [UITextField new];
    self.remarksField.placeholder = @"今天的花费在哪儿......";
    self.remarksField.font = Font(12);
    self.remarksField.minimumFontSize = 10;
    self.remarksField.keyboardType = UIKeyboardTypeDefault;
    self.remarksField.returnKeyType = UIReturnKeyDone;
    [self.topInfoView addSubview:self.remarksField];
    [self.remarksField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remarksLabel.mas_right).offset(5);
        make.height.mas_equalTo(LineH(25));
        make.width.mas_equalTo(LineW(135));
        make.centerY.equalTo(self.topInfoView.mas_centerY);
    }];
    //金额
    self.moneyField = [UITextField new];
    self.moneyField.textColor = [UIColor blackColor];
    self.moneyField.font = Font(18);
    self.moneyField.text = @"0.00";
    self.moneyField.textAlignment = NSTextAlignmentRight;
    self.moneyField.keyboardType = UIKeyboardTypeDecimalPad;
    self.moneyField.returnKeyType = UIReturnKeyDone;
    [self.topInfoView addSubview:self.moneyField];
    [self.moneyField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.cancelButton.mas_left).offset(-15);
        make.centerY.equalTo(self.topInfoView.mas_centerY);
        make.height.mas_equalTo(LineH(25));
        make.width.mas_equalTo(LineW(110));
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
