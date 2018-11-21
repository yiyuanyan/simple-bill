//
//  HttpTools.h
//  simple-bill
//
//  Created by Talk GoGo on 2018/10/25.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN
typedef void(^AFNSuccessResponse)(id responseObject);
typedef void(^AFNFailureResponse)(id error);
typedef void (^RefreshToken)(BOOL updateToken);
typedef NS_ENUM(NSInteger, HttpRequestType) {
    Get,
    Post,
    Delete,
    Put,
};
@interface HttpTools : NSObject
/** 网络状态监测 **/
@property(nonatomic, assign)AFNetworkReachabilityStatus netWorkStatus;
//请求管理者
@property(nonatomic, strong) AFHTTPSessionManager *manager;
+ (instancetype) share;
- (void) requestWithPath:(NSString *)url
                  method:(NSInteger)method
                  isLoginOrRegister:(BOOL)isLoginOrRegister
          viewController:(UIViewController *)viewController
                 success:(AFNSuccessResponse)success
                 failure:(AFNFailureResponse)failure;
//POST请求 带MBP
- (void)sendPostRequestWithPath:(NSString *)url
              isLoginOrRegister:(BOOL)isLoginOrRegister
                 viewController:(UIViewController *)viewController
                        success:(AFNSuccessResponse)success
                        failure:(AFNFailureResponse)failure;
//GET请求 带MBP
- (void)sendGetRequestWithPath:(NSString *)url
             isLoginOrRegister:(BOOL)isLoginOrRegister
                viewController:(UIViewController *)viewController
                       success:(AFNSuccessResponse)success
                       failure:(AFNFailureResponse)failure;

//@property(nonatomic ,strong)RefreshToken refreshToken;
//POST请求
//+(void)PostHttpDataWithUrlStr:(NSString *)url SuccessBlock:(SuccessBlock)successBlock FailedBlock:(FailedBlock)failedBlock;
//+(void)GetHttpDataWithUrlStr:(NSString *)url SuccessBlock:(SuccessBlock)successBlock FailedBlock:(FailedBlock)failedBlock;
//+ (BOOL)refreshBoolToken;

@end

NS_ASSUME_NONNULL_END
