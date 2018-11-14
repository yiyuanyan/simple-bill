//
//  BaseViewController.h
//  simple-bill
//
//  Created by 何建新 on 2018/10/9.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property(nonatomic, strong) UIView *topView;
//获取当前时间戳
+ (int )getNowTimeTimestamp;
+ (void) getNewToken:(NSString *)userPhone userPwd:(NSString *)userPwd;
//- (void)initCheckUserTokenTimeOut;
@end

NS_ASSUME_NONNULL_END
