//
//  CollectionViewCell.h
//  simple-bill
//
//  Created by 何建新 on 2018/11/28.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) CollectionModel *model;
@end

NS_ASSUME_NONNULL_END
