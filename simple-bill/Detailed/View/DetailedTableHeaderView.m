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
    self.dateLabel.font = SystemFont(14);
    self.dateLabel.text = @"";
    self.dateLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    [self addSubview:self.dateLabel];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(18);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    
}
-(void)setHeaderDic:(NSDictionary *)headerDic
{
    NSString *dateString = [self stringIntercept:headerDic[@"acc_date"]];
    NSString *day_Income = [NSString stringWithFormat:@"%@",headerDic[@"day_Income"]];
    NSString *day_expenditure = [NSString stringWithFormat:@"%@",headerDic[@"day_expenditure"]];
    self.dateLabel.text = dateString;
    //支出
    self.expenditureLabel = [UILabel new];
    self.expenditureLabel.font = SystemFont(14);
    NSLog(@"%@",Font(14));
    self.expenditureLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    //收入
    self.incomeLabel = [UILabel new];
    self.incomeLabel.font = SystemFont(14);
    
    self.incomeLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    
    if(!IsStrEmpty(day_expenditure) && ![day_expenditure isEqualToString:@"0"]){
        [self addSubview:self.expenditureLabel];
        self.expenditureLabel.text = [NSString stringWithFormat:@"支出:%@",day_expenditure];
        [self.expenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.mas_centerY);
        }];
        [self addSubview:self.incomeLabel];
        self.incomeLabel.text = [NSString stringWithFormat:@"收入:%@",day_Income];
        [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.expenditureLabel.mas_left).offset(-10);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }else{
        [self addSubview:self.incomeLabel];
        self.incomeLabel.text = [NSString stringWithFormat:@"收入:%@",day_Income];
        [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(18);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }
    if(IsStrEmpty(day_Income) || [day_Income isEqualToString:@"0"]){
        self.incomeLabel.hidden = YES;
    }
    
    
    
}
-(NSString *)stringIntercept:(NSString *)str {
    NSString *string = [str substringFromIndex:5];
    return string;
}
@end
