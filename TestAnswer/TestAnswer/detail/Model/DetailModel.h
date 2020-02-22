//
//  DetailModel.h
//  TestAnswer
//
//  Created by 谢飞 on 2020/2/21.
//  Copyright © 2020 谢飞. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject
@property(nonatomic, copy)NSString *productName;
@property(nonatomic, strong)NSArray *galleryList;
@property(nonatomic, copy)NSString *marketPrice;
@property(nonatomic, copy)NSString *salePrice;
@end

NS_ASSUME_NONNULL_END
