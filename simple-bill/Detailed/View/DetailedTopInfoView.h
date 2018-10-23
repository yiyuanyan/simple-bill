//
//  DetailedTopInfoView.h
//  simple-bill
//
//  Created by 何建新 on 2018/10/19.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^MonthButtonClickBlock)(UIView *monthButton);
@interface DetailedTopInfoView : UIView
@property(nonatomic, copy)MonthButtonClickBlock monthButtonCLickBlock;
@property(nonatomic, strong) UILabel *yearTitleLabel;
@property(nonatomic, strong) UILabel *monthLabel;
@property(nonatomic, strong) UILabel *incomeTitleLabel;
@property(nonatomic, strong) UILabel *expenditureTitleLabel;

@property(nonatomic, strong) UILabel *incomeLabel;
@property(nonatomic, strong) UILabel *expenditureLabel;
@property(nonatomic, strong) NSString *currentYear;
@property(nonatomic, strong) NSString *currentMonth;
@property(nonatomic, strong) NSString *incomeString;
@property(nonatomic, strong) NSString *expenditureString;
@end

NS_ASSUME_NONNULL_END
