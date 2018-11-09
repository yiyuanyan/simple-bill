//
//  BaseViewController.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/9.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //验证用户Token是否过期
    [self initCheckUserTokenTimeOut];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"简单记账";
    [self.navigationController.navigationBar setTitleTextAttributes:
     
     @{NSFontAttributeName:[UIFont systemFontOfSize:24],
       
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self setTopView];
    self.view.backgroundColor = UICOLOR_FROM_HEX(0xfefefe);
}
- (void)setTopView {
    self.topView = [[UIView alloc] init];
    self.topView.backgroundColor = UICOLOR_FROM_HEX(0xf9db61);
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT + 88);
    }];
    
}
- (void)initCheckUserTokenTimeOut {
    NSLog(@"验证用户Token是否过期");
    NSString *token = [NSString stringWithFormat:@"%@",[UserDefaults() objectForKey:@"user_token"]];
    NSInteger token_time_out = [[UserDefaults() objectForKey:@"token_time_out"] integerValue];
    int curr_time = [BaseViewController getNowTimeTimestamp];
    NSInteger difference = curr_time - token_time_out;
    if(difference > 60){
        NSLog(@"token已经超时");
    }else{
        NSLog(@"token还未超时");
    }
    
}
+ (int )getNowTimeTimestamp{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *nowDateString = [dateFomatter stringFromDate:nowDate];
    NSDate *nowDate1 = [dateFomatter dateFromString:nowDateString];
    NSTimeInterval interval = [nowDate1 timeIntervalSince1970];
    NSString *str = [NSString stringWithFormat:@"%.0f",interval];
    int time = [str intValue];
    return time;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
