//
//  AccountsTopView.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/27.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "AccountsTopView.h"

@implementation AccountsTopView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initTopView];
    }
    return self;
}
- (void)initTopView{
    self.backgroundColor = UICOLOR_FROM_HEX(0xf9db61);
    self.buttonBackgroundView = [UIView new];
    
    [self addSubview:self.buttonBackgroundView];
    [self.buttonBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(LineW(131));
        make.height.mas_equalTo(LineH(25));
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    //支出按钮
    self.expenditureBtn = [UIButton new];
    [self.expenditureBtn setTitle:@"支出" forState:UIControlStateNormal];
    [self.expenditureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.expenditureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.buttonBackgroundView addSubview:self.expenditureBtn];
    [self.expenditureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.buttonBackgroundView.mas_top).offset(0);
        make.left.equalTo(self.buttonBackgroundView.mas_left).offset(LineX(8));
        make.width.mas_equalTo(LineW(40));
        make.height.mas_equalTo(LineH(20));
    }];
    //收入按钮
    self.incomeBtn = [UIButton new];
    [self.incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    [self.incomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.incomeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.buttonBackgroundView addSubview:self.incomeBtn];
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.expenditureBtn.mas_width);
        make.height.equalTo(self.expenditureBtn.mas_height);
        make.right.equalTo(self.buttonBackgroundView.mas_right).offset(-LineX(8));
        make.centerY.equalTo(self.expenditureBtn.mas_centerY);
    }];
    //标注线
    self.markerLine = [UIView new];
    self.markerLine.backgroundColor = [UIColor blackColor];
    [self.buttonBackgroundView addSubview:self.markerLine];
    [self.markerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buttonBackgroundView.mas_left).offset(0);
        make.height.mas_equalTo(3);
        make.bottom.equalTo(self.buttonBackgroundView.mas_bottom).offset(-0);
        make.width.mas_equalTo(LineW(56));
    }];
    /*
    //支出按钮
    self.expenditureBtn = [UIButton new];
    [self.expenditureBtn setTitle:@"支出" forState:UIControlStateNormal];
    [self.expenditureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.expenditureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.expenditureBtn];
    [self.expenditureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self.mas_left).offset(LineX(148));
        make.centerX.equalTo(self.mas_centerX).offset(-LineX(40));
        make.bottom.equalTo(self.mas_bottom).offset(-16);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    //收入按钮
    self.incomeBtn = [UIButton new];
    [self.incomeBtn setTitle:@"收入" forState:UIControlStateNormal];
    [self.incomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.incomeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self addSubview:self.incomeBtn];
    [self.incomeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.expenditureBtn.mas_width);
        make.height.equalTo(self.expenditureBtn.mas_height);
        make.left.equalTo(self.expenditureBtn.mas_right).offset(40);
        make.centerY.equalTo(self.expenditureBtn.mas_centerY);
    }];
    //标注线
    self.markerLine = [UIView new];
    self.markerLine.backgroundColor = [UIColor blackColor];
    [self addSubview:self.markerLine];
    [self.markerLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.expenditureBtn.mas_centerX);
        make.height.mas_equalTo(3);
        make.bottom.equalTo(self.mas_bottom).offset(-0);
        make.width.mas_equalTo(54);
    }];
    //取消按钮
    self.cancelBtn = [UIButton new];
    [self.cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-25);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(15);
        make.centerY.equalTo(self.incomeBtn.mas_centerY);
    }];
     */
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
