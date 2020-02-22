//
//  ItemCell.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/22.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *itemTf;

@end

NS_ASSUME_NONNULL_END
