//
//  DetailSelectController.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/22.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "DetailSelectController.h"
#import "ImageCell.h"
#import "SizeCell.h"
#import <UIImageView+WebCache.h>

@interface DetailSelectController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *sizeCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *imageCollectionView;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic, strong) NSMutableArray *imageArr;
@property (nonatomic, strong) NSMutableArray *sizeArr;

@end

@implementation DetailSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArr = [NSMutableArray array];
    self.sizeArr = [NSMutableArray array];
    [self initData];
    self.amountLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.amountLabel.layer.borderWidth = 1;
    
    [self.imageCollectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    [self.sizeCollectionView registerNib:[UINib nibWithNibName:@"SizeCell" bundle:nil] forCellWithReuseIdentifier:@"SizeCell"];
    // Do any additional setup after loading the view from its nib.
}
- (void)initData {
    NSDictionary *data = [self readLocalFileWithName:@"data"];
    NSDictionary *data2 = [data valueForKey:@"result"];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://pic.bonwebuy.com%@",[data2 valueForKey:@"productUrl"]]]];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",[data2 valueForKey:@"salePrice"]];
    NSArray *imageDict = [[data2 valueForKey:@"saleAttrList"] valueForKey:@"saleAttr1List"];
    for (NSDictionary *dict in imageDict) {
        [self.imageArr addObject:[dict valueForKey:@"imageUrl"]];
    }
    NSArray *sizes = [[data2 valueForKey:@"saleAttrList"] valueForKey:@"saleAttr2List"];
    for (NSDictionary *dict in sizes) {
        [self.sizeArr addObject:[dict valueForKey:@"saleAttr2Value"]];
    }

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

- (IBAction)decreaseAction:(UIButton *)sender {
    NSInteger mount = [self.amountLabel.text integerValue];
    if (mount>0) {
        mount -= 1;
    }
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)mount];
}
- (IBAction)increaseAction:(UIButton *)sender {
    NSInteger mount = [self.amountLabel.text integerValue];
    mount += 1;
    self.amountLabel.text = [NSString stringWithFormat:@"%ld",(long)mount];
}

- (IBAction)sureAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDelegate UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.imageCollectionView) {
        return self.imageArr.count;
    }
    return self.sizeArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    if (collectionView == self.imageCollectionView) {
        NSString *imgUrl = self.imageArr[indexPath.row];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
        [((ImageCell*)cell).icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://pic.bonwebuy.com%@",imgUrl]]];
    }else {
        NSString *size = self.sizeArr[indexPath.row];
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SizeCell" forIndexPath:indexPath];
        ((SizeCell*)cell).sizeLabel.text = size;
    }
    return cell;
}
@end
