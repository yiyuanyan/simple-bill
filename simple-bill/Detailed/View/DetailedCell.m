//
//  DetailedCell.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/22.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "DetailedCell.h"

@implementation DetailedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self initCellView];
    }
    return self;
}
- (void)initCellView {
    UIView *separatorLine = [UIView new];
    separatorLine.backgroundColor = UICOLOR_FROM_HEX(0xcccccc);
    [self addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.mas_bottom).offset(0);
    }];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"电器_"]];
//    imgView.backgroundColor = UICOLOR_FROM_HEX(0xf9db61);
//    //设置圆角
//    imgView.layer.cornerRadius = 6;
//    //将多余的部分切掉
//    imgView.layer.masksToBounds = YES;
    [self addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(30);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
    }];
}
@end
