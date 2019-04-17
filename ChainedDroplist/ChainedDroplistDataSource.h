//
//  ChainedDroplistDataSource.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//  交易 droplist table view 使用的 datasource

#import <Foundation/Foundation.h>

@protocol ChainedDroplistModelProtocol;
@interface ChainedDroplistDataSource : NSObject <UITableViewDataSource>

/**
 初始化 datasource 的数组
 */
@property (nonatomic, strong) NSArray <id<ChainedDroplistModelProtocol>> *cellDatas;

@end
