//
//  AddressCell.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^EditBlock)(AddressModel*);
@interface AddressCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingDefaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, copy) EditBlock block;
- (void)setDataModel:(AddressModel *)model;
@end

NS_ASSUME_NONNULL_END
