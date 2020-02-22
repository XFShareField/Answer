//
//  ScrollViewCell.m
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import "ScrollViewCell.h"
#import "DetailModel.h"


@implementation ScrollViewCell
{
    DetailModel *dataModel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setCellData:(DetailModel*)model{
    dataModel = model;
    self.imageScrollView.delegate = self;
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary* dict in dataModel.galleryList) {
        [arr addObject:[NSString stringWithFormat:@"https://pic.bonwebuy.com%@", dict[@"imageUrl"]]];
    }
    NSLog(@"%@",arr);
    self.imageScrollView.imageURLStringsGroup = arr;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",dataModel.salePrice];
    self.originLabel.text = [NSString stringWithFormat:@"初始市场价：￥%@",dataModel.marketPrice];
}
@end
