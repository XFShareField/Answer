//
//  AddressCell.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell
{
    AddressModel *dataModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.settingDefaultBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.editBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.deleteBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.settingDefaultBtn.layer.borderWidth =1;
    self.editBtn.layer.borderWidth = 1;
    self.deleteBtn.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setDataModel:(AddressModel *)model {
    dataModel = model;
    self.nameLabel.text = model.consignee;
    self.phoneLabel.text = model.mobile;
    if (model.isdefault) {
        self.settingDefaultBtn.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.settingDefaultBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@",dataModel.provinceName,dataModel.cityName,dataModel.districtName];
}
- (IBAction)deleteAction:(id)sender {
}
- (IBAction)editAction:(id)sender {
    if (self.block) {
        self.block(dataModel);
    }
}
- (IBAction)setDefaultAction:(UIButton*)sender {
    [sender setSelected:!sender.selected];
    if (sender.isSelected) {
        self.settingDefaultBtn.layer.borderColor = [UIColor redColor].CGColor;
    } else {
        self.settingDefaultBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
}

@end
