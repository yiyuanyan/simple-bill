//
//  DetailedCell.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/22.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "DetailedCell.h"
@interface DetailedCell()
@property(nonatomic, strong) UIImageView *iconView;
@property(nonatomic, strong) UILabel *cateLabel;
@property(nonatomic, strong) UILabel *moneyLabel;
@end
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
    self.iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dianqi"]];
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(30);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(20);
    }];
    self.cateLabel = [UILabel new];
    self.cateLabel.font = SystemFont(14);
    self.cateLabel.textColor = UICOLOR_FROM_HEX(0x000000);
    [self addSubview:self.cateLabel];
    [self.cateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(18);
    }];
    
    self.moneyLabel = [UILabel new];
    self.moneyLabel.font = SystemFont(14);
    self.moneyLabel.textColor = UICOLOR_FROM_HEX(0x999999);
    [self addSubview:self.moneyLabel];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(18);
    }];
}
-(void)setModel:(DetailedCellModel *)model {
    if(!IsStrEmpty(model.thumb)){
        NSURL *imgURL = [NSURL URLWithString:model.thumb];
        [self.imageView sd_setImageWithURL:imgURL];
    }else{
        self.iconView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_",model.en_name]];
    }
    self.cateLabel.text = model.name;
    self.moneyLabel.text = [NSString stringWithFormat:@"%@",model.money];
    
}
@end
