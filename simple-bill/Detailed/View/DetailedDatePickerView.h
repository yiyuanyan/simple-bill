//
//  DetailedDatePickerView.h
//  simple-bill
//
//  Created by 何建新 on 2018/11/23.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailedDatePickerView : UIView
@property(nonatomic, strong) UIButton *confirmButton;
@property(nonatomic, strong) UIButton *cancelButton;
@property(nonatomic, strong) UIPickerView *picker;
@end

NS_ASSUME_NONNULL_END
