//
//  DetalViewController.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "DetalViewController.h"
#import "ScrollViewCell.h"
#import <MJExtension/MJExtension.h>
#import "DetailModel.h"
#import "AddressViewController.h"
#import "DetailSelectController.h"

@interface DetalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *homeBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;
@property (weak, nonatomic) IBOutlet UIButton *shopCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *joinShopCartBtn;
@property (weak, nonatomic) IBOutlet UIButton *purchaseBtn;
@property (nonatomic, strong)DetailModel *dataModel;

@end

@implementation DetalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self initData];
    [self.tableView registerNib:[UINib nibWithNibName:@"ScrollViewCell" bundle:nil] forCellReuseIdentifier:@"ScrollViewCell"];
    [self setViewBorder:self.homeBtn];
    [self setViewBorder:_shopCartBtn];
    [self setViewBorder:self.joinShopCartBtn];
    [self setViewBorder:self.serviceBtn];
    [self setViewBorder:self.purchaseBtn];
    // Do any additional setup after loading the view from its nib.
}
- (void)setViewBorder:(UIView *)view {
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view.layer.borderWidth = 1;
}
- (IBAction)goHomeAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)purchaseAction:(id)sender {
    NSLog(@"跳往地址列表");
    AddressViewController *vc = [[AddressViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)initData{
    NSDictionary *detailDic = [self readLocalFileWithName:@"data"];
    self.dataModel = [DetailModel mj_objectWithKeyValues:detailDic[@"result"]];
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
#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"ScrollViewCell"];
        [(ScrollViewCell*)cell setCellData:self.dataModel];
    }
    else {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"请选择颜色、配送方式、尺码、数量";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        DetailSelectController *vc = [[DetailSelectController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 650;
    }
    return 88;
}
@end
