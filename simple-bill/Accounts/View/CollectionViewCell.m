//
//  CollectionViewCell.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/28.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "CollectionViewCell.h"
@interface CollectionViewCell()
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *categoryName;
@end
@implementation CollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCellUI];
    }
    return self;
}
- (void)initCellUI{
    self.imageBackgroundView = [UIView new];
    self.imageBackgroundView.backgroundColor = UICOLOR_FROM_HEX(0xf5f5f5);
    self.imageBackgroundView.layer.masksToBounds = YES;
    self.imageBackgroundView.layer.cornerRadius = LineH(50) / 2;
    [self addSubview:self.imageBackgroundView];
    [self.imageBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.width.height.mas_equalTo(LineH(50));
        make.centerX.equalTo(self.mas_centerX);
    }];
    self.imageView = [[UIImageView alloc] init];
    [self.imageBackgroundView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(LineH(25));
        make.centerX.equalTo(self.imageBackgroundView.mas_centerX);
        make.centerY.equalTo(self.imageBackgroundView.mas_centerY);
    }];
    self.categoryName = [UILabel new];
    [self addSubview:self.categoryName];
    [self.categoryName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(LineH(15));
        make.bottom.equalTo(self.mas_bottom);
    }];
}
-(void)setModel:(CollectionModel *)model
{
    if(!IsStrEmpty(model.thumb)){
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.thumb]];
    }else{
        [self.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_",model.en_name]]];
    }
    self.categoryName.text = model.name;
    self.categoryName.font = Font(12);
    self.categoryName.textColor = UICOLOR_FROM_HEX(0x333333);
    self.categoryName.textAlignment = NSTextAlignmentCenter;
}
@end
