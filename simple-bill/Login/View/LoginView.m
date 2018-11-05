//
//  LoginView.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/5.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initWithLoginView];
    }
    return self;
}
-(void)initWithLoginView {
    self.backgroundColor = UICOLOR_FROM_HEX(0xffffff);
    UIImageView *headIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head"]];
    [self addSubview:headIcon];
    [headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(LineH(88));
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).offset(LineH(63));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
