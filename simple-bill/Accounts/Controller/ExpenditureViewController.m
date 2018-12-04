//
//  ExpenditureViewController.m
//  simple-bill
//
//  Created by 何建新 on 2018/11/29.
//  Copyright © 2018 何建新. All rights reserved.
//

#import "ExpenditureViewController.h"
#import "CollectionViewCell.h"
#import "CollectionModel.h"
#import "InputView.h"  //价格输入View
@interface ExpenditureViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) CollectionViewCell *cell;
@property(nonatomic, strong) NSIndexPath *selectCellIndexPath;
@property(nonatomic, strong) InputView *inputView;
@end

@implementation ExpenditureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT())];
    
    //创建collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT()) collectionViewLayout:layout];
    self.collectionView.pagingEnabled = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collectionView];
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.expModelArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.expModelArray[indexPath.row];
    
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(LineW(62), LineH(82));
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
//cell点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[self.collectionView reloadData];
    if(self.selectCellIndexPath != indexPath){
        CollectionViewCell * cell = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:self.selectCellIndexPath];
        cell.imageBackgroundView.backgroundColor = UICOLOR_FROM_HEX(0xf5f5f5);
    }
    
    CollectionViewCell * cell2 = (CollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell2.imageBackgroundView.backgroundColor = [UIColor yellowColor];
    self.selectCellIndexPath = indexPath;

    CollectionModel *cellModel = self.expModelArray[indexPath.row];
    if(self.inputView != nil){
        [self.inputView removeFromSuperview];
    }
    self.inputView = [InputView new];
    [self.view addSubview:self.inputView];
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(LineH(274));
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    NSLog(@"%@",cellModel.id);
    NSLog(@"被点击了");
}

@end
