//
//  CollectionModel.h
//  simple-bill
//
//  Created by 何建新 on 2018/11/30.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CollectionModel : NSObject
@property(nonatomic, strong) NSString *id;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *en_name;
@property(nonatomic, assign) int type;
@property(nonatomic, strong) NSString *thumb;
@property(nonatomic, assign) int status;
@end

NS_ASSUME_NONNULL_END
