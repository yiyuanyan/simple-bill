//
//  DetailedController.m
//  simple-bill
//
//  Created by 何建新 on 2018/10/9.
//  Copyright © 2018 何建新. All rights reserved.
//  明细
#import "DetailedController.h"
#import "BaseTabBarController.h"
#import "DetailedTopInfoView.h"
#import "DetailedCell.h"
#import "DetailedTableHeaderView.h"
#import "DetailedCellModel.h"
@interface DetailedController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) DetailedTopInfoView *detailedTopInfoView;
@property(nonatomic, strong) NSString *currentYear;  //当前年份
@property(nonatomic, strong) NSString *currentMonth; //当前月份
@property(nonatomic, strong) NSString *currentDay;  //当前天
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *tableHeaderArray;  //tableHeader数据
@property(nonatomic, strong) NSMutableArray *cellData;  //cell数据
@end

@implementation DetailedController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取当前时间
    [self getcurrentYearMonthDay];
    //设置顶部视图
    [self setDetailedTopInfoView];
    //tableView
    self.cellData = [NSMutableArray array];
    self.tableHeaderArray = [NSMutableArray array];

    
    //获取网络数据
    //[self GetHttpInfo:[NSString stringWithFormat:@"%@/detailed/2018-10",BASE_URL]];
    //[self GetHttpInfo:@"http://yiyuanyan.ecip.net:81/detailed/2018-10"];
    NSString *url = [NSString stringWithFormat:@"%@%@-%@",DETAILET_URL,self.currentYear,self.currentMonth];
    [self GetHttpInfo:@"http://yiyuanyan.eicp.net:81/detailed/2018-10"];
    
    
    
}
//设置顶部视图
- (void)setDetailedTopInfoView {
    
    self.detailedTopInfoView = [[DetailedTopInfoView alloc] init];
    [self.view addSubview:self.detailedTopInfoView];
    [self.detailedTopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.topView.mas_bottom).offset(0);
    }];
    self.detailedTopInfoView.currentYear = [NSString stringWithFormat:@"%@年",self.currentYear];
    self.detailedTopInfoView.currentMonth = [NSString stringWithFormat:@"%@月",self.currentMonth];
    //月份view点击事件
    self.detailedTopInfoView.monthButtonCLickBlock = ^(UIView * _Nonnull monthButton) {
        NSLog(@"月份View被点击啦");
    };
    //收入
    self.detailedTopInfoView.incomeString = @"";
    //支出
    self.detailedTopInfoView.expenditureString = @"";
    
}
#pragma mark --设置TableView
- (void)initTableView {
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = YES;
    //去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(1);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(CONTENT_HEIGHT);
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.cellData[section] count];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DetailedTableHeaderView *view = [[DetailedTableHeaderView alloc] init];
    view.headerDic = self.tableHeaderArray[section];
    
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellString = @"DetailedCell";
    DetailedCell *cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if(!cell){
        cell = [[DetailedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    cell.model = self.cellData[indexPath.section][indexPath.row];
    return cell;
}

#pragma mark --获取当前时间
- (void)getcurrentYearMonthDay {
    NSDate *date = [NSDate date];
    NSCalendar *cal = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *d = [cal components:unitFlags fromDate:date];
    self.currentYear = [NSString stringWithFormat:@"%ld",(long)[d year]];
    self.currentMonth = [NSString stringWithFormat:@"%ld",(long)[d month]];
    self.currentDay = [NSString stringWithFormat:@"%ld",(long)[d day]];
}
#pragma mark --请求网络数据
-(void)GetHttpInfo:(NSString *)url {
    [MBProgressHUD showLoading:self.view title:@"Loading..."];
    [[HttpTools share] sendPostRequestWithPath:url isLoginOrRegister:NO viewController:self success:^(id  _Nonnull responseObject) {
        NSLog(@"有数据啦：%@",responseObject);
    } failure:^(id  _Nonnull error) {
        
    }];
    
}


@end
