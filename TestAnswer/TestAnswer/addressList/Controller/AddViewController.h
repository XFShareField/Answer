//
//  AddViewController.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^SaveBlock)(AddressModel*);
@interface AddViewController : UIViewController
@property(nonatomic, strong)AddressModel *model;
@property(nonatomic, assign)BOOL isEdit;
@property(nonatomic, copy)SaveBlock block;
@end

NS_ASSUME_NONNULL_END
