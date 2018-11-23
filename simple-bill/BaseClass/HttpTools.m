//
//  HttpTools.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/10/25.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "HttpTools.h"
@interface HttpTools()
@property(nonatomic, assign) BOOL isShowMBP;
@end
@implementation HttpTools
+ (instancetype)share
{
    static HttpTools *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        Permissions *permissions = [Permissions sharedPermissions];
        //获得网络监控管理者
        AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
        //网络状态发生改变后的处理
        [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //当网络改变调用block
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:  //未知网络
                    self.netWorkStatus = AFNetworkReachabilityStatusUnknown;
                    permissions.netStatus = NO;
#ifdef DEBUG
                    [self showExceptionDialog:@"未知网络"];
#endif
                    break;
                    case AFNetworkReachabilityStatusNotReachable:  //没有网络（断网）
                    self.netWorkStatus = AFNetworkReachabilityStatusNotReachable;
                    permissions.netStatus = NO;
#ifdef DEBUG
                    [self showExceptionDialog:@"没有网络或断网"];
#endif
                    break;
                    case AFNetworkReachabilityStatusReachableViaWWAN:  //2G/3G/4G网络
                    self.netWorkStatus = AFNetworkReachabilityStatusReachableViaWWAN;
                    permissions.netStatus = YES;
#ifdef DEBUG
                    [self showExceptionDialog:@"2G/3G/4G网络"];
#endif
                    break;
                    case AFNetworkReachabilityStatusReachableViaWiFi:  //WIFI网络
                    self.netWorkStatus = YES;
                    permissions.netStatus = YES;
#ifdef DEBUG
                    [self showExceptionDialog:@"WIFI网络"];
#endif
                    break;
                    
                default:
                    break;
            }
        }];
        [mgr startMonitoring];
    }
    return self;
}
- (void)showExceptionDialog:(NSString *)message
{
    NSLog(@"%@",message);
}
-(void)requestWithPath:(NSString *)url method:(NSInteger)method isLoginOrRegister:(BOOL)isLoginOrRegister viewController:(UIViewController *)viewController success:(AFNSuccessResponse)success failure:(AFNFailureResponse)failure
{
    self.manager = [AFHTTPSessionManager manager];
    //url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [MBProgressHUD hideHUDForView:viewController.view];
    if(self.isShowMBP){
        [MBProgressHUD showLoading:viewController.view];
    }
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"charset=utf-8", nil];
    if(isLoginOrRegister == NO){
        //设置header头 注:laravel 不支持下划线_
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[UserDefaults() objectForKey:@"user_token"]] forHTTPHeaderField:@"token"];
        [self.manager.requestSerializer setValue:[NSString stringWithFormat:@"%@",[UserDefaults() objectForKey:@"u_id"]] forHTTPHeaderField:@"id"];
    }
    
    switch (method) {
        case Get:
            {
                [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [MBProgressHUD hideHUDForView:viewController.view];
                    NSDictionary *dic = responseObject;
                    if([dic[@"status"] intValue] == 1){
                        success(responseObject);
                        NSLog(@"%@-GET请求地址:\n%@---success日志：\n%@",[viewController class],url,responseObject);
                    }else if([dic[@"dataus"] intValue] == 99){
                        //TOKEN过期
                        NSLog(@"%@-GET请求：\n%@----TOKEN已过期：\n%@",[viewController class],url,responseObject);
                        [self refreshToken:url method:method viewController:viewController success:success failure:failure];
                        return ;
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(error);
                    NSLog(@"%@-GET请求：\n%@----服务器返回错误：\n%@",[viewController class],url,error);
                }];
            }
            break;
        case Post:
            {
                [self.manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"%@-POST请求地址:\n%@---success日志：\n%@",[viewController class],url,responseObject);
                    NSDictionary *dic = responseObject;
                    if([dic[@"status"] intValue] == 1){
                        success(responseObject);
                        
                    }else if([dic[@"status"] intValue] == 99){
                        NSLog(@"%@-POST请求：\n%@----TOKEN已过期：\n%@",[viewController class],url,responseObject);
                        [self refreshToken:url method:method viewController:viewController success:success failure:failure];
                        return ;
                    }else if([dic[@"status"] intValue] == 0){
                        NSLog(@"%@-POST请求：\n%@----非法用户：\n%@------Token:\n%@------u_id:\n%@",[viewController class],url,responseObject,[NSString stringWithFormat:@"%@",[UserDefaults() objectForKey:@"user_token"]],[NSString stringWithFormat:@"%@",[UserDefaults() objectForKey:@"u_id"]]);
                        [MBProgressHUD hideHUDForView:viewController.view];
                        [MBProgressHUD showMessage:responseObject[@"msg"] toView:viewController.view];
                        return;
                    }else{
                        NSLog(@"%@-POST请求地址:\n%@---其他错误：\n%@",[viewController class],url,responseObject);
                        [MBProgressHUD hideHUDForView:viewController.view];
                        [MBProgressHUD showMessage:responseObject[@"msg"] toView:viewController.view];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    failure(error);
                    NSLog(@"%@-POST请求：\n%@----服务器返回错误：\n%@",[viewController class],url,error);
                }];
            }
            break;
        default:
            break;
    }
}
- (void)sendGetRequestWithPath:(NSString *)url isLoginOrRegister:(BOOL)isLoginOrRegister viewController:(UIViewController *)viewController success:(AFNSuccessResponse)success failure:(AFNFailureResponse)failure
{
    self.isShowMBP = YES;
    [self requestWithPath:url method:Get isLoginOrRegister:isLoginOrRegister viewController:viewController success:success failure:failure];
}
- (void)sendPostRequestWithPath:(NSString *)url isLoginOrRegister:(BOOL)isLoginOrRegister viewController:(UIViewController *)viewController success:(AFNSuccessResponse)success failure:(AFNFailureResponse)failure
{
    self.isShowMBP = YES;
    [self requestWithPath:url method:Post isLoginOrRegister:isLoginOrRegister viewController:viewController success:success failure:failure];
}
//更新TOKEN
- (void)refreshToken:(NSString *)url method:(NSInteger)method viewController:(UIViewController *)viewController success:(AFNSuccessResponse)success failure:(AFNFailureResponse)failure{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    NSString *path = [NSString stringWithFormat:@"%@%@/%@",UPDATE_TOKEN,[UserDefaults() objectForKey:@"user_phone"],[UserDefaults() objectForKey:@"user_pwd"]];
    [manage POST:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@-POST请求：\n%@----更新Token：\n%@",[viewController class],path,responseObject);
        if([responseObject[@"status"] intValue] == 1){
            [UserDefaults() setObject:responseObject[@"data"][@"token"] forKey:@"user_token"];
            [UserDefaults() setObject:responseObject[@"data"][@"token_time_out"] forKey:@"token_time_out"];
            [UserDefaults() synchronize];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //再次发送请求
                [self requestWithPath:url method:method isLoginOrRegister:NO viewController:viewController success:success failure:failure];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}
@end
