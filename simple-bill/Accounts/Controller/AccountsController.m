//
//  AccountsController.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/9.
//  Copyright © 2018 何建新. All rights reserved.
//  记账

#import "AccountsController.h"
#import "AccountsTopView.h"
#import "ScrollView.h"
#import "ExpenditureViewController.h"  //支出View控制器
#import "IncomeViewController.h"    //收入View控制器

@interface AccountsController ()<UIScrollViewDelegate>
@property(nonatomic, strong)ScrollView *scrollView;
@property(nonatomic, strong) ExpenditureViewController *expenditureView; //支出View
@property(nonatomic, strong) IncomeViewController *incomeView;   //收入view
@property(nonatomic, strong) AccountsTopView *topView;
@end

@implementation AccountsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.toolbarHidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:nil];
    self.view.backgroundColor = UICOLOR_RANDOM_COLOR();
    [self initTopView];
    [self topButtonAction];
    //创建scrollView
    [self initScrollView];

    // Do any additional setup after loading the view.
}
- (void)initTopView{
    self.topView = [AccountsTopView new];
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view).offset(0);
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    
    
}
- (void)topButtonAction {
    @weakify(self);
    //支出按钮
    [[self.topView.expenditureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"点击了支出按钮");
        [UIView animateWithDuration:0.3 animations:^{
            self.topView.markerLine.frame = CGRectMake(0, self.topView.buttonBackgroundView.frame.size.height - 3, LineW(56), 3);
        }];
    }];
    //收入按钮
    [[self.topView.incomeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了收入按钮");
         @strongify(self);
        [UIView animateWithDuration:0.3 animations:^{
            self.topView.markerLine.frame = CGRectMake(self.topView.buttonBackgroundView.frame.size.width - self.topView.markerLine.frame.size.width, self.topView.buttonBackgroundView.frame.size.height - 3, LineW(56), 3);
        }];
    }];
    //取消按钮
    [[self.topView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了取消按钮");
         @strongify(self);
    }];
}
#pragma mark  -- 创建ScrollView
- (void)initScrollView {
    self.scrollView = [[ScrollView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, self.view.frame.size.width, self.view.frame.size.height-NAVIGATION_BAR_HEIGHT-TAB_BAR_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * 2, self.scrollView.frame.size.height);
    [self.view addSubview:self.scrollView];
    
    self.expenditureView = [ExpenditureViewController new];
    [self.expenditureView.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH(), self.scrollView.frame.size.height)];
    [self.scrollView addSubview:self.expenditureView.view];
    
    self.incomeView = [IncomeViewController new];
    [self.incomeView.view setFrame:CGRectMake(self.expenditureView.view.frame.size.width, 0, SCREEN_WIDTH(), self.scrollView.frame.size.height)];
    [self.scrollView addSubview:self.incomeView.view];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.x > 0 && scrollView.contentOffset.x < SCREEN_WIDTH()){
        //标示线移动的距离
        CGFloat x2 = self.topView.buttonBackgroundView.frame.size.width - self.topView.markerLine.frame.size.width;
        //scrollView移动的距离
        CGFloat x3 = SCREEN_WIDTH();
        //移动比例
        CGFloat x4 = x2 / x3;
        self.topView.markerLine.frame = CGRectMake(scrollView.contentOffset.x * x4, self.topView.buttonBackgroundView.frame.size.height - 3, LineW(56), 3);
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
