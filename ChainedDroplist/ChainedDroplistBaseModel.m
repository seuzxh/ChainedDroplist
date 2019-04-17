//
//  ChainedDroplistBaseModel.m
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2019/4/12.
//

#import "ChainedDroplistBaseModel.h"
#import "ChainedDroplistDef.h"

@implementation ChainedDroplistBaseModel

#pragma mark - ChainedDroplistModelProtocol
@synthesize strCellIdentifier, isCellSelected, needBottomSepline;
- (NSString *)strCellIdentifier
{
    return kChainedDroplistBaseCellIdentifier;
}

@end
