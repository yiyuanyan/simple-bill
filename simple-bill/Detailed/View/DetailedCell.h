//
//  DetailedCell.h
//  simple-bill
//
//  Created by 何建新 on 2018/10/22.
//  Copyright © 2018 何建新. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailedCellModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface DetailedCell : UITableViewCell
@property(nonatomic, strong) DetailedCellModel *model;
@end

NS_ASSUME_NONNULL_END
