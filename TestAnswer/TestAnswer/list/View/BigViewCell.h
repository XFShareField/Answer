//
//  BigViewCell.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;
NS_ASSUME_NONNULL_BEGIN

@interface BigViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountlabe;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
- (void)setDataModel:(ListModel *)model;
@end

NS_ASSUME_NONNULL_END
