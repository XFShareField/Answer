//
//  AddressModel.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject
@property(nonatomic,copy)NSString *provinceName;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *districtName;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *consignee;
@property(nonatomic,assign)BOOL isdefault;
@end

NS_ASSUME_NONNULL_END
