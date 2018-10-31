//
//  DetailedTableHeaderView.h
//  simple-bill
//
//  Created by 何建新 on 2018/10/23.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailedTableHeaderView : UIView
@property(nonatomic, strong) UILabel *dateLabel;  //日期Label
@property(nonatomic, strong) UILabel *totalExpenditureLabel;  //支出总和Label
@property(nonatomic, strong) UILabel *totalExpenditureTitleLabel;//支出总和TitleLabel
@property(nonatomic, strong) UILabel *totalIncomeLabel;  //收入总和Label
@property(nonatomic, strong) UILabel *totalIncomeTitleLabel; //收入总和TitleLabel
@property(nonatomic, strong) NSString *dateString;  //日期字符串
@property(nonatomic, strong) NSString *totalExpenditureString;  //支出总和字符串
@property(nonatomic, strong) NSString *totalIncomeString;  //收入总和字符串
@end

NS_ASSUME_NONNULL_END
