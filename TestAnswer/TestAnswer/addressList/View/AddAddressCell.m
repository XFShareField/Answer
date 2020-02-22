//
//  AddAddressCell.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "AddAddressCell.h"

@implementation AddAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.addLabel.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor darkGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
