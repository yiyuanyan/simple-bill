//
//  Permissions.h
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/19.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Permissions : NSObject
+ (Permissions *)sharedPermissions;
//网络状态
@property(nonatomic) BOOL netStatus;
@end

NS_ASSUME_NONNULL_END
