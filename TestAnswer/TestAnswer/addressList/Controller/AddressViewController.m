//
//  AddressViewController.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "AddressViewController.h"
#import "AddressCell.h"
#import "AddAddressCell.h"
#import "AddressModel.h"
#import <MJExtension/MJExtension.h>
#import "AddViewController.h"

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property(nonatomic, strong)NSMutableArray *data;

@end

@implementation AddressViewController
- (NSMutableArray*)data {
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    // Do any additional setup after loading the view from its nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:@"AddressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"AddAddressCell" bundle:nil] forCellReuseIdentifier:@"AddAddressCell"];
}
- (void)initData{
    NSDictionary *detailDic = [self readLocalFileWithName:@"address"];
    NSArray *arr = detailDic[@"result"];
    NSArray *models = [AddressModel mj_objectArrayWithKeyValuesArray:arr];
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
#pragma mark- UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return  self.data.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section < self.data.count) {
        AddressModel *model = self.data[indexPath.section];
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell"];
        [(AddressCell *)cell setDataModel:model];
        ((AddressCell *)cell).block = ^(AddressModel * newModel) {
            AddViewController *vc = [[AddViewController alloc]init];
            vc.model = newModel;
            vc.block = ^(AddressModel * saveModel) {
                self.data[indexPath.section] = saveModel;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:vc animated:YES];
        };
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 128;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == self.data.count) {
        NSLog(@"跳转新增地址");
        AddViewController *vc = [[AddViewController alloc]init];
        vc.block = ^(AddressModel * newModel) {
            [self.data addObject:newModel];
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
