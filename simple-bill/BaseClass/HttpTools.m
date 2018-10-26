//
//  HttpTools.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/10/25.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "HttpTools.h"

@implementation HttpTools
+(void)PostHttpDataWithUrlStr:(NSString *)url SuccessBlock:(SuccessBlock)successBlock FailedBlock:(FailedBlock)failedBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json",nil];
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successBlock){
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failedBlock){
            failedBlock(error);
        }
    }];
}
+ (void)GetHttpDataWithUrlStr:(NSString *)url SuccessBlock:(SuccessBlock)successBlock FailedBlock:(FailedBlock)failedBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain",@"text/json", nil];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(successBlock){
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failedBlock){
            failedBlock(error);
        }
    }];
}
@end
