//
//  ListModel.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject
@property (nonatomic, copy)NSString *brandName;
@property (nonatomic, copy)NSString *imgUrl;
@property (nonatomic, copy)NSString *productId;
@property (nonatomic, copy)NSString *productName;
@property (nonatomic, copy)NSString *marketPrice;
@property (nonatomic, copy)NSString *saleCount;
@property (nonatomic, copy)NSString *salesPrice;
@property (nonatomic, assign)NSInteger stock;
@property (nonatomic, copy)NSString *discount;
@end

NS_ASSUME_NONNULL_END
