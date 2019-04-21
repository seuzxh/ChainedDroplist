//
//  ChainedDroplistCustomerModel.m
//  ChainedDroplist_Example
//
//  Created by seuzxh@163.com on 2019/4/18.
//  Copyright © 2019 seuzxh. All rights reserved.
//

#import "ChainedDroplistCustomerModel.h"

/*
 在 Model 中实现 identifier 的定义，
 声明与定义分离的好处是可以根据 identifier 搜索到相互关联的 cell 和 model
 
 */
NSString *const kChainedDroplistCustomerCellIdentifier = @"ChainedDroplistCustomerCellIdentifier";

@implementation ChainedDroplistCustomerModel

#pragma mark - ChainedDroplistModelProtocol
- (NSString *)strCellIdentifier
{
    /*
        return customer cell identifier
     */
    return kChainedDroplistCustomerCellIdentifier;
}

@end
