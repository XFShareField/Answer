//
//  AddViewController.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "AddViewController.h"
#import "AddAddressCell.h"
#import "ItemCell.h"

@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *data;
@property (nonatomic, strong)NSArray *details;
@property (nonatomic, assign)NSInteger currentRow;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *phone;
@property (nonatomic, copy)NSString *city;
@property (nonatomic, copy)NSString *addr;
@property (nonatomic, assign)BOOL isCancel;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLayConst;
@property (nonatomic, strong)NSArray *proviences;
@property (nonatomic, strong)NSArray *citiesArr;
@property (nonatomic, strong)NSArray *distArr;
@property (nonatomic, strong)NSDictionary *all;
@property (nonatomic, copy)NSString *selectP;
@property (nonatomic, copy)NSString *selectC;
@property (nonatomic, copy)NSString *selectD;
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _data = @[@"收货人",@"手机号",@"所在地区",@"详细地址"];
    [self initData];
    self.city = self.model ? [NSString stringWithFormat:@"%@%@",self.model.provinceName,self.model.cityName] : @"";
    self.name = self.model ? self.model.consignee : @"";
    self.phone = self.model ? self.model.mobile : @"";
    self.addr = self.model ? self.model.districtName  : @"";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AddAddressCell" bundle:nil] forCellReuseIdentifier:@"AddAddressCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ItemCell" bundle:nil] forCellReuseIdentifier:@"ItemCell"];
    // Do any additional setup after loading the view from its nib.
}
- (void)initData{
    self.all = [self readLocalFileWithName:@"city"];
    self.proviences = [self.all allKeys];
    NSString *defaultCity = self.proviences[0];
    self.selectP = defaultCity;
    _citiesArr = [[self.all objectForKey:defaultCity] allKeys];
    NSString *defaultDist = _citiesArr[0];
    self.selectC = defaultDist;
    self.distArr = [[self.all objectForKey:defaultCity] objectForKey:defaultDist];
    self.selectD = self.distArr[0];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    
    if (indexPath.row < 4) {

        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = self.data[indexPath.row];
        NSString *detail = @"";
        switch (indexPath.row) {
            case 0:
                detail = self.name;
                break;
            case 1:
                detail = self.phone;
                break;
            case 2:
                detail = self.city;
                break;
            case 3:
                detail = self.addr;
                break;
            default:
                break;
        }
        cell.detailTextLabel.text = detail;
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell"];
        ((AddAddressCell *)cell).addLabel.textColor = [UIColor whiteColor];
        ((AddAddressCell *)cell).addLabel.backgroundColor = [UIColor blackColor];
        ((AddAddressCell *)cell).addLabel.text = @"保存";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < 4 && indexPath.row != 2) {
        [self alertText:indexPath.row];
    }else if (indexPath.row == 2){
        NSLog(@"跳出地址选择器");
        [self showPicker];
    }else {
        //保存收件人相关信息
        if (!self.name || !self.phone || !self.addr || !self.city) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"信息不能为空" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }];
            return;
        } else if (![self isValidateMobile:self.phone]){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"电话号码格式不正确" message:nil preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }];
            return;
        }
        if (self.block) {
            AddressModel *model = [[AddressModel alloc]init];
            model.mobile = self.phone;
            model.consignee = self.name;
            model.districtName = self.selectD;
            model.cityName = self.selectC;
            model.provinceName = self.selectP;
            self.block(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}
- (void)showPicker {
    UIView *mask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-260)];
    mask.tag = 1001;
    mask.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view insertSubview:mask belowSubview:self.pickView];
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomLayConst.constant = 0;
    }];
}
- (void)hidePicker {
    [UIView animateWithDuration:0.25 animations:^{
        UIView *mask = [self.view viewWithTag:1001];
        [mask removeFromSuperview];
        self.bottomLayConst.constant = -260;
    }];
}
- (void)alertText:(NSInteger)row {
    NSString *title = @"";
    self.currentRow = row;
    if (row == 0) {
        title = @"请输入新的收件人姓名";
    }
    if(row == 1) {
        title = @"请输入新的收件人电话";
    }
    if (row == 3) {
        title = @"请输入新的收件人详细地址";
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleAlert];
     [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         self.isCancel = YES;
     }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        self.isCancel = NO;
    }]];

    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.delegate = self;
    }];
    [self presentModalViewController:alert animated:YES];
}
- (BOOL) isValidateMobile:(NSString *)mobile
{

NSString *phoneRegex1=@"1[3456789]([0-9]){9}";
NSPredicate *phoneTest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex1];
return [phoneTest1 evaluateWithObject:mobile];
}
#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.isCancel) {
        self.isCancel = NO;
        return;
    }
    switch (self.currentRow) {
        case 0:
            self.name = textField.text;
            break;
        case 1:
            self.phone = textField.text;
            break;
        case 3:
            self.addr = textField.text;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}
// 获取市列表
- (void)getCitysOf:(NSString *)city {
    NSDictionary *cities = [self.all objectForKey:city];
    self.citiesArr = [cities allKeys];
    NSString *c = self.citiesArr[0];
    [self getDistrictsOf:c];
}
- (void)getDistrictsOf:(NSString*)city {
    NSDictionary *cities = [self.all objectForKey:self.selectP];
    self.distArr = [cities objectForKey:city];
}
#pragma mark - UIPickerViewDelegate UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.proviences.count;
        case 1:
            return self.citiesArr.count;
        case 2:
            return self.distArr.count;
        default:
            break;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return self.proviences[row];
        case 1:
            return self.citiesArr[row];
        case 2:
            return self.distArr[row];
        default:
            break;
    }
    return @"";
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    switch (component) {
        case 0:
        {
            NSString *pro = self.proviences[row];
            self.selectP = pro;
            [self getCitysOf:pro];
            [self.pickView reloadComponent:1];
            [self.pickView reloadComponent:2];
            break;
        }
        case 1:
            {
                NSString *pro = self.citiesArr[row];
                self.selectC = pro;
                [self getDistrictsOf:pro];
                [self.pickView reloadComponent:2];
                break;
            }
        case 2:
            self.selectD = self.distArr[row];
            break;
        default:
            break;
    }

}
- (IBAction)cancelAction:(id)sender {
    [self hidePicker];
}
- (IBAction)sureAction:(id)sender {
    self.city = [NSString stringWithFormat:@"%@%@%@",self.selectP,self.selectC,self.selectD];
    [self.tableView reloadData];
    [self hidePicker];
}
@end
