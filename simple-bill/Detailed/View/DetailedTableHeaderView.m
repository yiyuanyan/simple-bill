//
//  DetailedTableHeaderView.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/23.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "DetailedTableHeaderView.h"
@interface DetailedTableHeaderView()
@property(nonatomic, strong) UILabel *dateLabel;  //日期
@property(nonatomic, strong) UILabel *incomeLabel;  //收入
@property(nonatomic, strong) UILabel *expenditureLabel;  //支出
@end
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
    self.backgroundColor = UICOLOR_FROM_HEX(0xeeeeee);
    self.dateLabel = [UILabel new];
    self.dateLabel.font = Font(14);
    self.dateLabel.text = @"";
    self.dateLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(18);
        make.centerY.equalTo(self.mas_centerY);
    }];
    //支出
    self.expenditureLabel = [UILabel new];
    self.expenditureLabel.font = Font(14);
    self.expenditureLabel.text = @"支出:-300";
    self.expenditureLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    [self addSubview:self.expenditureLabel];
    [self.expenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_equalTo(18);
        make.centerY.equalTo(self.mas_centerY);
    }];
    //收入
    self.incomeLabel = [UILabel new];
    self.incomeLabel.font = Font(14);
    self.incomeLabel.text = @"收入:300";
    self.incomeLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    [self addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.expenditureLabel.mas_left).offset(-10);
        make.height.mas_equalTo(18);
        make.centerY.equalTo(self.mas_centerY);
    }];
}
-(void)setHeaderDic:(NSDictionary *)headerDic
{
    NSLog(@"%@",headerDic);
    NSString *dateString = [self stringIntercept:headerDic[@"acc_date"]];
    NSString *day_Income = [NSString stringWithFormat:@"%@",headerDic[@"day_Income"]];
    NSString *day_expenditure = [NSString stringWithFormat:@"%@",headerDic[@"day_expenditure"]];
    self.dateLabel.text = dateString;
    //隐藏收入
    if([day_Income isEqualToString:@"0"]){
        self.incomeLabel.hidden = YES;
    }else{
        self.incomeLabel.text = [NSString stringWithFormat:@"收入:%@",day_Income];
    }
    //隐藏支出
    if([day_expenditure isEqualToString:@"0"]){
        self.expenditureLabel.hidden = YES;
        [self.incomeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.expenditureLabel.mas_left).offset(-10);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self.incomeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }else{
        self.expenditureLabel.text = [NSString stringWithFormat:@"支出:%@",day_expenditure];;
    }
    
    
}
-(NSString *)stringIntercept:(NSString *)str {
    NSString *string = [str substringFromIndex:5];
    return string;
}
@end
