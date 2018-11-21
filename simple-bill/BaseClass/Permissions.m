//
//  Permissions.m
//  simple-bill
//
//  Created by Talk GoGo on 2018/11/19.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "Permissions.h"
static Permissions *permissions = nil;
@implementation Permissions
+ (Permissions *)sharedPermissions
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        permissions = [Permissions new];
        
    });
    return permissions;
}
@end
