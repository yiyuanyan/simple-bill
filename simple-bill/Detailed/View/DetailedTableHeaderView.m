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
    self.totalExpenditureTitleLabel = [UILabel new];
    self.totalExpenditureTitleLabel.font = Font(12);
    self.totalExpenditureTitleLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    self.totalExpenditureTitleLabel.text = @"支出：";
    [self addSubview:self.totalExpenditureTitleLabel];
    
    [self.totalExpenditureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.totalExpenditureLabel.mas_left).offset(0);
        make.height.mas_equalTo(38);
    }];
    //收入
    self.totalIncomeLabel = [UILabel new];
    self.totalIncomeLabel.text = @"";
    self.totalIncomeLabel.font = Font(12);
    [self addSubview:self.totalIncomeLabel];
    [self.totalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(38);
    }];
    //收入title
    self.totalIncomeTitleLabel = [UILabel new];
    self.totalIncomeTitleLabel.font = Font(12);
    self.totalIncomeTitleLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    self.totalIncomeTitleLabel.text = @"支出：";
    [self addSubview:self.totalIncomeTitleLabel];
    
    [self.totalIncomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.totalIncomeLabel.mas_left).offset(0);
        make.height.mas_equalTo(38);
    }];
    
    
}
-(void)setDateString:(NSString *)dateString
{
    self.dateLabel.font = Font(12);
    NSString *str2 = [dateString substringFromIndex:5];
    self.dateLabel.text = str2;
    self.dateLabel.textColor = UICOLOR_FROM_HEX(0x999999);
}
-(void)setTotalExpenditureString:(NSString *)totalExpenditureString {
    self.totalExpenditureString = totalExpenditureString;
    self.totalExpenditureLabel.font = Font(12);
    self.totalExpenditureLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    self.totalExpenditureLabel.text = totalExpenditureString;
}
-(void)setTotalIncomeString:(NSString *)totalIncomeString
{
    self.totalIncomeLabel.font = Font(12);
    self.totalIncomeLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    self.totalIncomeLabel.text = totalIncomeString;
    if(IsStrEmpty(self.totalExpenditureString)){
        [self.totalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
        }];
    }else{
        [self.totalIncomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.totalExpenditureTitleLabel.mas_left).offset(-30);
        }];
    }
}
@end
