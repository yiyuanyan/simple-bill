//
//  DetailedCellModel.h
//  simple-bill
//
//  Created by 何建新 on 2018/10/29.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailedCellModel : NSObject
/*
 "id": 1,
 "user_id": 1,
 "cate_id": 3,
 "type": 0,
 "money": "-897",
 "acc_date": "2018年10月16日 星期一",
 "upload_date": "1540519948"
 */
@property(nonatomic, assign) NSInteger *id;
@property(nonatomic, assign) NSInteger *user_id;
@property(nonatomic, assign) NSInteger *cate_id;
@property(nonatomic, assign) NSInteger *type;
@property(nonatomic, strong) NSString *en_name;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *thumb;
@property(nonatomic, strong) NSString *money;
@property(nonatomic, strong) NSString *acc_date;
@property(nonatomic, strong) NSString *upload_date;

@end

NS_ASSUME_NONNULL_END
