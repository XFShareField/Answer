//
//  ScrollViewCell.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDCycleScrollView.h>
@class DetailModel;
NS_ASSUME_NONNULL_BEGIN

@interface ScrollViewCell : UITableViewCell<SDCycleScrollViewDelegate>
@property (weak, nonatomic) IBOutlet SDCycleScrollView *imageScrollView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
- (void)setCellData:(DetailModel*)model;
@end

NS_ASSUME_NONNULL_END
