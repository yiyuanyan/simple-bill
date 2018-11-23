//
//  DetailedTopInfoView.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/19.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "DetailedTopInfoView.h"

@implementation DetailedTopInfoView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initDetailedTopTitleView];
        [self initDetailedTopInfoView];
    }
    return self;
}
- (void)initDetailedTopTitleView {
    self.yearTitleLabel = [UILabel new];
    [self addSubview:self.yearTitleLabel];
    [self.yearTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(22);
        make.height.mas_equalTo(16);
        make.bottom.equalTo(self.mas_bottom).offset(-51);
    }];
    self.incomeTitleLabel = [UILabel new];
    [self addSubview:self.incomeTitleLabel];
    [self.incomeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yearTitleLabel.mas_centerY).offset(0);
        make.height.mas_equalTo(16);
        make.left.equalTo(self.mas_left).offset(137);
    }];
    self.incomeTitleLabel.font = SystemFont(14);
    self.incomeTitleLabel.text = @"收入";
    self.incomeTitleLabel.textColor = UICOLOR_FROM_HEX(0x333333);
    self.expenditureTitleLabel = [UILabel new];
    [self addSubview:self.expenditureTitleLabel];
    [self.expenditureTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yearTitleLabel.mas_centerY).offset(0);
        make.left.equalTo(self.mas_left).offset(277);
        make.height.mas_equalTo(16);
    }];
    self.expenditureTitleLabel.text = @"支出";
    self.expenditureTitleLabel.font = SystemFont(14);
    self.expenditureTitleLabel.textColor = UICOLOR_FROM_HEX(0x333333);
}
- (void)initDetailedTopInfoView {
    UIView *monthBackView = [UIView new];
    monthBackView.userInteractionEnabled = YES;
    //添加点击事件
    [monthBackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(monthButtonCLickBlockAction:)] ];
    [self addSubview:monthBackView];
    [monthBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.yearTitleLabel.mas_left).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(83);
    }];
    UIView *shuxian = [UIView new];
    shuxian.backgroundColor = UICOLOR_FROM_HEX(0x000000);
    [monthBackView addSubview:shuxian];
    [shuxian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(monthBackView.mas_right).offset(-1);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(1);
    }];
    self.monthLabel = [UILabel new];
    self.monthLabel.font = SystemFont(12);
    self.monthLabel.textColor = UICOLOR_FROM_HEX(0x000000);
    [monthBackView addSubview:self.monthLabel];
    [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(monthBackView.mas_left).offset(1);
        make.centerY.equalTo(monthBackView.mas_centerY);
        make.height.mas_equalTo(28);
        
    }];
    UIImageView *sanjiaoView = [[UIImageView alloc] init];
    sanjiaoView.image = UIIMAGE_FROM_NAME(@"sanjiao");
    
    [monthBackView addSubview:sanjiaoView];
    [sanjiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.monthLabel.mas_right).offset(0);
        make.centerY.equalTo(monthBackView.mas_centerY);
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(12);
    }];
    self.incomeLabel = [UILabel new];
    [self addSubview:self.incomeLabel];
    [self.incomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(monthBackView.mas_bottom).offset(0);
        make.left.equalTo(self.incomeTitleLabel.mas_left).offset(0);
        make.right.equalTo(self.expenditureTitleLabel.mas_left).offset(10);
        make.height.mas_equalTo(28);
    }];
    //支出
    self.expenditureLabel = [UILabel new];
    [self addSubview:self.expenditureLabel];
    [self.expenditureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.expenditureTitleLabel.mas_left).offset(0);
        make.bottom.equalTo(self.incomeLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(28);
        make.right.equalTo(self.mas_right).offset(20);
    }];
    
    
}
- (void)monthButtonCLickBlockAction:(UIView *)monthBackView {
    if(self.monthButtonCLickBlock){
        self.monthButtonCLickBlock(monthBackView);
    }
}
-(void)setCurrentYear:(NSString *)currentYear
{
    self.yearTitleLabel.font = SystemFont(14);
    self.yearTitleLabel.textColor = UICOLOR_FROM_HEX(0x333333);
    self.yearTitleLabel.text = [NSString stringWithFormat:@"%@年",currentYear];
}
-(void)setCurrentMonth:(NSString *)currentMonth {
    if(!IsStrEmpty(currentMonth)){
        NSString *m = [NSString stringWithFormat:@"%@月",currentMonth];
        NSMutableAttributedString *month = [self stringAttribute:m rangeString:@"月" font:Font(24)];
        self.monthLabel.textColor = UICOLOR_FROM_HEX(0x000000);
        self.monthLabel.attributedText = month;
    }
}
- (void)setIncomeString:(NSString *)incomeString {
    if(!IsStrEmpty(incomeString)){
        self.incomeLabel.font = SystemFont(12);
        NSMutableAttributedString *income = [self stringAttribute:incomeString rangeString:@"." font:Font(20)];
        self.incomeLabel.textColor = UICOLOR_FROM_HEX(0x000000);
        self.incomeLabel.attributedText = income;
    }
    
}
-(void)setExpenditureString:(NSString *)expenditureString {
    if(!IsStrEmpty(expenditureString)){
        self.expenditureLabel.font = SystemFont(12);
        self.expenditureLabel.textColor = UICOLOR_FROM_HEX(0x000000);
        NSMutableAttributedString *expenditure = [self stringAttribute:expenditureString rangeString:@"." font:Font(20)];
        self.expenditureLabel.attributedText = expenditure;
    }
}
//富文本设置
- (NSMutableAttributedString *)stringAttribute:(NSString *)string rangeString:(NSString *)rangeString font:(UIFont *)font{
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:string];
    //改变rangeString前面的文字属性
    NSRange range = [string rangeOfString:rangeString];
    NSRange pointRange = NSMakeRange(0, range.location);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = font;
    //赋值并返回
    [attribut addAttributes:dic range:pointRange];
    return attribut;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
