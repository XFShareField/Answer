//
//  SmallViewCell.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "SmallViewCell.h"
#import "ListModel.h"
#import <SDWebImage/SDWebImage.h>
@implementation SmallViewCell
{
    ListModel *dataModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.discountLabe.layer.borderColor = [UIColor redColor].CGColor;
    self.discountLabe.layer.borderWidth = 1;
}
- (void)setDataModel:(ListModel *)model{
    dataModel = model;
    self.nameLabel.text = dataModel.productName;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%@",dataModel.salesPrice];
    self.marketLabel.text = [NSString stringWithFormat:@"￥%@",dataModel.marketPrice];
    NSLog(@"图片地址%@",[NSString stringWithFormat:@" https:%@",dataModel.imgUrl]);
    self.discountLabe.text = [NSString stringWithFormat:@"%@折",dataModel.discount];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",dataModel.imgUrl]] placeholderImage:nil];
    
}
@end
