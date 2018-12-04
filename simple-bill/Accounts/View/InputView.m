//
//  InputView.m
//  simple-bill
//
//  Created by 何建新 on 2018/12/4.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "InputView.h"

@implementation InputView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initInputViewUI];
    }
    return self;
}
- (void)initInputViewUI {
    self.backgroundColor = UICOLOR_RANDOM_COLOR();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
