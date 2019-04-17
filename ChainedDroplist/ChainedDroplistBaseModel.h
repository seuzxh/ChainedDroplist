//
//  ChainedDroplistBaseModel.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2019/4/12.
//

#import <Foundation/Foundation.h>
@protocol ChainedDroplistModelProtocol;

FOUNDATION_EXPORT NSString *const kChainedDroplistBaseCellIdentifier;

@interface ChainedDroplistBaseModel : NSObject <ChainedDroplistModelProtocol>

@property (nonatomic, copy) NSString *strTitle;

@end
