//
//  DetailedDatePickerView.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/23.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "DetailedDatePickerView.h"

@implementation DetailedDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}
- (void)initUI{
    UIView *buttonBackgroundView = [UIView new];
    buttonBackgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttonBackgroundView];
    [buttonBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"请选择时间";
    titleLabel.font = Font(14);
    titleLabel.textColor = [UIColor blackColor];
    [buttonBackgroundView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(buttonBackgroundView.mas_centerY);
        make.centerX.equalTo(buttonBackgroundView.mas_centerX);
    }];
    //确认、取消按钮
    self.confirmButton = [[UIButton alloc] init];
    [self.confirmButton setTitle:@"确认" forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = Font(14);
    [buttonBackgroundView addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(buttonBackgroundView.mas_left).offset(20);
        make.centerY.equalTo(buttonBackgroundView.mas_centerY);
    }];
    self.cancelButton = [UIButton new];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButton.titleLabel.font = Font(14);
    [buttonBackgroundView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buttonBackgroundView.mas_right).offset(-20);
        make.centerY.equalTo(buttonBackgroundView.mas_centerY);
    }];
    //DatePicker
    self.picker = [UIPickerView new];
    self.picker.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.picker];
    [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(buttonBackgroundView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
    }];
}
@end
