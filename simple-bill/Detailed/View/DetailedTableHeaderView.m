//
//  DetailedTableHeaderView.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/23.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "DetailedTableHeaderView.h"

@implementation DetailedTableHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initTableHeaderView];
    }
    return self;
}
#pragma makr --初始化UI
- (void)initTableHeaderView {
    self.backgroundColor = UICOLOR_FROM_HEX(0xf5f5f5);
    //日期
    self.dateLabel = [UILabel new];
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(18);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(38);
    }];
    
    //支出
    self.totalExpenditureLabel = [UILabel new];
    self.totalExpenditureLabel.text = @"100000";
    self.totalExpenditureLabel.font = Font(12);
    [self addSubview:self.totalExpenditureLabel];
    [self.totalExpenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(38);
    }];
    //支出title
    UILabel *totalExpenditureTitleLabel = [UILabel new];
    totalExpenditureTitleLabel.font = Font(12);
    totalExpenditureTitleLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    totalExpenditureTitleLabel.text = @"支出：";
    [self addSubview:totalExpenditureTitleLabel];
    
    [totalExpenditureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.totalExpenditureLabel.mas_left).offset(0);
        make.height.mas_equalTo(38);
    }];
    
    
}
-(void)setDateString:(NSString *)dateString
{
    self.dateLabel.font = Font(12);
    self.dateLabel.text = dateString;
    self.dateLabel.textColor = UICOLOR_FROM_HEX(0x999999);
}
-(void)setTotalExpenditureString:(NSString *)totalExpenditureString {
    self.totalExpenditureLabel.font = Font(12);
    self.totalExpenditureLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    self.totalExpenditureLabel.text = totalExpenditureString;
}
@end
