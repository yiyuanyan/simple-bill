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
typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailedBlock)(id error);
@interface HttpTools : NSObject
//POST请求
+(void)PostHttpDataWithUrlStr:(NSString *)url SuccessBlock:(SuccessBlock)successBlock FailedBlock:(FailedBlock)failedBlock;
+(void)GetHttpDataWithUrlStr:(NSString *)url SuccessBlock:(SuccessBlock)successBlock FailedBlock:(FailedBlock)failedBlock;
@end

NS_ASSUME_NONNULL_END
