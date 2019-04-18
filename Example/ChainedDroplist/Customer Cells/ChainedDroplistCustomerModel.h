//
//  ChainedDroplistCustomerModel.h
//  ChainedDroplist_Example
//
//  Created by seuzxh@163.com on 2019/4/18.
//  Copyright © 2019 seuzxh. All rights reserved.
//

#import "ChainedDroplistBaseModel.h"

@interface ChainedDroplistCustomerModel : ChainedDroplistBaseModel <ChainedDroplistModelProtocol>

@property (nonatomic, copy) NSString *customerTitle;
@property (nonatomic, copy) NSString *customerDetail;

@end

