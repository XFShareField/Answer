//
//  ViewController.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "ViewController.h"
#import "SmallViewCell.h"
#import "BigViewCell.h"
#import "ListModel.h"
#import <MJExtension/MJExtension.h>
#import "DetalViewController.h"
#define SCREEN_WIDETH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *data;

@property (nonatomic, assign)BOOL isBig;

@end

@implementation ViewController


#pragma mark - lazy
- (NSMutableArray *)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return  _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isBig = YES;
    self.navigationController.navigationBar.translucent = NO;
    [self initData];
    [self setMenu];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDETH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"SmallViewCell" bundle:nil] forCellWithReuseIdentifier:@"SmallViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"BigViewCell" bundle:nil] forCellWithReuseIdentifier:@"BigViewCell"];
    [self.view addSubview:_collectionView];
}
- (void)initData {
    NSDictionary *listDict = [self readLocalFileWithName:@"list"];
    NSArray *products = listDict[@"data"][@"list"];
    NSArray *models = [ListModel mj_objectArrayWithKeyValuesArray:products];
    [self.data addObjectsFromArray:models];
}
- (NSDictionary *)readLocalFileWithName:(NSString *)name
{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    return [NSJSONSerialization JSONObjectWithData:data
                                           options:kNilOptions
                                             error:nil];
}
- (void)setMenu {
    NSArray *titles = @[@"综合",@"价格",@"有货",@"筛选",@"切换视图"];
    for (int i = 0; i < 5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i* SCREEN_WIDETH/5, 0, SCREEN_WIDETH/5, 64);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        btn.backgroundColor = [UIColor whiteColor];
        if (i == 4) {
            [btn addTarget:self action:@selector(changeViewMode:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:btn];
    }
}

- (void)changeViewMode:(UIButton *)btn {
    self.isBig = !self.isBig;
    [self.collectionView reloadData];
}
#pragma mark -UICollectionViewDelegateFlowLayout

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  self.isBig ? UIEdgeInsetsZero : UIEdgeInsetsMake(0, 10, 0, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return  0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.isBig ? CGSizeMake(self.view.bounds.size.width, 200) : CGSizeMake(175, 340);
}
#pragma mark - UICollectionViewDataSource UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return  4;
    return  self.data.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    ListModel *model = [self.data objectAtIndex:indexPath.row];
    if (self.isBig) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigViewCell" forIndexPath:indexPath];
        [(BigViewCell *)cell setDataModel:model];
    } else {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallViewCell" forIndexPath:indexPath];
        [(SmallViewCell *)cell setDataModel:model];
    }
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetalViewController *vc = [[DetalViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
