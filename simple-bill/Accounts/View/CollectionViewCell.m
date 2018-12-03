//
//  CollectionViewCell.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/28.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UICOLOR_RANDOM_COLOR();
    }
    return self;
}
@end
