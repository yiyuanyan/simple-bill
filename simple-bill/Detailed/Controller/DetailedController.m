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
#import "DetailedDatePickerView.h"

@interface DetailedController ()<UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate>
@property(nonatomic, strong) DetailedTopInfoView *detailedTopInfoView;
@property(nonatomic, strong) NSString *currentYear;  //当前年份
@property(nonatomic, strong) NSString *currentMonth; //当前月份
@property(nonatomic, strong) NSString *currentDay;  //当前天
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSMutableArray *tableHeaderArray;  //tableHeader数据
@property(nonatomic, strong) NSMutableArray *cellData;  //cell数据
@property(nonatomic, strong) DetailedDatePickerView *datePickerView;  //时间选择器
@property(nonatomic, strong) UIView *backgroundView;  //开启时间选择器时的蒙版
@property(nonatomic, assign) BOOL isShowPicker;  //是否显示时间选择器
@property(nonatomic, strong) NSArray *pickerYear;  //选择器年份
@property(nonatomic, strong) NSArray *pickerMonth;  //选择器月份
@end

@implementation DetailedController
-(NSArray *)pickerYear{
    if(_pickerYear == nil){
        NSDate *date = [NSDate date];
        NSCalendar *cal = [NSCalendar currentCalendar];
        unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
        NSDateComponents *d = [cal components:unitFlags fromDate:date];
        int year = (int)[d year];
        NSMutableArray *mArray = [NSMutableArray array];
        for(int i=0;i<5;i++){
            int a = year - (4 - i);
            [mArray addObject:[NSString stringWithFormat:@"%d年",a]];
        }
        
        _pickerYear = mArray;
    }
    return _pickerYear;
}
- (NSArray *)pickerMonth {
    if (_pickerMonth == nil) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i=1; i<=12; i++) {
            [mArray addObject:[NSString stringWithFormat:@"%d月",i]];
        }
        _pickerMonth = mArray;
    }
    return _pickerMonth;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //获取当前时间
    [self getcurrentYearMonthDay];
    //设置顶部视图
    [self setDetailedTopInfoView];
    //tableView
    self.cellData = [NSMutableArray array];
    self.tableHeaderArray = [NSMutableArray array];
    //初始化TableView
    [self initTableView];
    //初始化DatePicker
    //[self initDatePickerView];
    
    //获取网络数据
    //[self GetHttpInfo:[NSString stringWithFormat:@"%@/detailed/2018-10",BASE_URL]];
    //[self GetHttpInfo:@"http://yiyuanyan.ecip.net:81/detailed/2018-10"];
    NSString *url = [NSString stringWithFormat:@"%@%@-%@",DETAILET_URL,self.currentYear,self.currentMonth];
    [self GetHttpInfo:@"http://yiyuanyan.eicp.net:81/detailed/2018-10"];
    
    
    
}
//创建DatePicker
- (void)initDatePickerView{
    
    self.backgroundView = [UIView new];
    
    [self.view addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
    }];
    self.datePickerView = [DetailedDatePickerView new];
    self.datePickerView.backgroundColor = [UIColor whiteColor];
    self.datePickerView.picker.delegate = self;
    self.datePickerView.picker.dataSource = self;
    
    [self.view.window addSubview:self.datePickerView];
    [self.datePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view.window);
        make.bottom.equalTo(self.view.window.mas_bottom).offset(250);
        make.height.mas_equalTo(250);
    }];
    @weakify(self);
    [[self.datePickerView.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了时间选择器的确认按钮");
    }];
    [[self.datePickerView.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击了时间选择器的取消按钮");
    }];
    
}
- (void)unSetDatePickerView {
    NSLog(@"移除时间选择器");
    [self.datePickerView removeFromSuperview];
    [self.backgroundView removeFromSuperview];
}
- (void)cancle{
    
}
//设置顶部视图
- (void)setDetailedTopInfoView {
    
    
    @weakify(self);
    self.detailedTopInfoView = [[DetailedTopInfoView alloc] init];
    [self.view addSubview:self.detailedTopInfoView];
    [self.detailedTopInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.topView.mas_bottom).offset(0);
    }];
    self.detailedTopInfoView.currentYear = self.currentYear;
    self.detailedTopInfoView.currentMonth = self.currentMonth;
    //月份view点击事件
    self.detailedTopInfoView.monthButtonCLickBlock = ^(UIView * _Nonnull monthButton) {
        @strongify(self);
        if(!self.isShowPicker){
            NSLog(@"创建并显示时间选择器");
            [self initDatePickerView];
            [self.datePickerView.superview layoutIfNeeded];
            [UIView animateWithDuration:0.3 animations:^{
                self.backgroundView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.7];
                [self.datePickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.view.window.mas_bottom).offset(-0);
                }];
                [self.datePickerView.superview layoutIfNeeded];
            }];
            
            
        }else{
            [self unSetDatePickerView];
        }
        self.isShowPicker = !self.isShowPicker;
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
    if(IsArrEmpty(self.cellData)){
        return 0;
    }else{
        return [self.cellData[section] count];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DetailedTableHeaderView *view = [[DetailedTableHeaderView alloc] init];
    if(!IsArrEmpty(self.tableHeaderArray)){
        view.headerDic = self.tableHeaderArray[section];
    }
    
    
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

#pragma mark -- UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return self.pickerYear.count;
    }else if(component == 1){
        return self.pickerMonth.count;
    }
    return 0;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        return self.pickerYear[row];
    }else if(component == 1){
        return self.pickerMonth[row];
    }
    return nil;
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
        NSMutableArray *mHeader = [NSMutableArray array];
        NSMutableArray *mCell = [NSMutableArray array];
        for (NSDictionary *dic in responseObject[@"data"]) {
            [mHeader addObject:dic[@"headerInfo"]];
            NSMutableArray *dataArray2 = [NSMutableArray array];
            for (NSDictionary *cellDic in dic[@"info"]) {
                DetailedCellModel *cellModel = [DetailedCellModel yy_modelWithJSON:cellDic];
                [dataArray2 addObject:cellModel];
            }
            [mCell addObject:dataArray2];

        }
        self.tableHeaderArray = mHeader;
        
        self.cellData = mCell;
        [self.tableView reloadData];
        //年月赋值
        if(!IsStrEmpty(responseObject[@"date"])){
            NSDictionary *yearAndMonth = [self splitString:responseObject[@"date"] range:@"-"];
            self.detailedTopInfoView.currentYear = yearAndMonth[@"year"];
            self.detailedTopInfoView.currentMonth = yearAndMonth[@"month"];
        }else{
            self.detailedTopInfoView.currentYear = self.currentYear;
            self.detailedTopInfoView.currentMonth = self.currentMonth;
        }
        //收入支出赋值
        self.detailedTopInfoView.expenditureString = responseObject[@"expenditure"] ? responseObject[@"expenditure"] : @"0.00";
        self.detailedTopInfoView.incomeString = responseObject[@"income"] ? responseObject[@"income"] : @"0.00";
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(id  _Nonnull error) {
        
    }];
    
}

- (NSDictionary *)splitString:(NSString *)string range:(NSString *)rangeString{
    NSArray *array = [string componentsSeparatedByString:rangeString];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"year"] = array[0];
    dict[@"month"] = array[1];
    return dict;
}

@end
