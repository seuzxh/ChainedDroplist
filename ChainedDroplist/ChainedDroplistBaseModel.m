//
//  ChainedDroplistBaseModel.m
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2019/4/12.
//

#import "ChainedDroplistBaseModel.h"

@implementation ChainedDroplistBaseModel

#pragma mark - ChainedDroplistModelProtocol
@synthesize strCellIdentifier, needBottomSepline;
- (NSString *)strCellIdentifier
{
    return kChainedDroplistBaseCellIdentifier;
}

@end
