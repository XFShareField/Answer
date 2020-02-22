//
//  SizeCell.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/22.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "SizeCell.h"

@implementation SizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sizeLabel.layer.borderWidth = 1;
    self.sizeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    // Initialization code
}

@end
