//
//  ExpenditureViewController.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/29.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "ExpenditureViewController.h"
#import "CollectionViewCell.h"
@interface ExpenditureViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) CollectionViewCell *cell;
@end

@implementation ExpenditureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UICOLOR_RANDOM_COLOR();
    //获取支出分类列表
    NSString *url = [NSString stringWithFormat:@"%@category/1",BASE_URL];
    [self getCategory:url];
}
- (void)getCategory:(NSString *)url {
    [MBProgressHUD showLoading:self.view];
    [[HttpTools share] sendPostRequestWithPath:url isLoginOrRegister:NO viewController:self success:^(id  _Nonnull responseObject) {
        for (NSDictionary *dic in responseObject[@"data"]) {
            
        }
    } failure:^(id  _Nonnull error) {
        
    }];
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
