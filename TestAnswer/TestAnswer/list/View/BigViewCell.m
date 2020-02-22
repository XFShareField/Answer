//
//  BigViewCell.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "BigViewCell.h"
#import "ListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation BigViewCell
{
    ListModel *dataModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.discountlabe.layer.borderColor = [UIColor redColor].CGColor;
    self.discountlabe.layer.borderWidth = 1;

}
- (void)setDataModel:(ListModel *)model {
    dataModel = model;
    self.nameLabel.text = dataModel.productName;
    self.priceLabel.text =[NSString stringWithFormat:@"￥%@",dataModel.salesPrice];
    self.marketLabel.text = [NSString stringWithFormat:@"￥%@",dataModel.marketPrice];
    NSLog(@"图片地址%@",[NSString stringWithFormat:@" https:%@",dataModel.imgUrl]);
    [self.icon sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https:%@",dataModel.imgUrl]] placeholderImage:nil];
    self.discountlabe.text = [NSString stringWithFormat:@"%@折",dataModel.discount];
}
@end
