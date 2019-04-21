//
//  ChainedDroplistDataSource.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//  Datasource used for chain UITableView

#import <Foundation/Foundation.h>

@protocol ChainedDroplistModelProtocol;
@interface ChainedDroplistDataSource : NSObject <UITableViewDataSource>

/**
 init UITableView DataSource

 @param datas Datas list used for datasource
 @return datasource instance
 */
- (instancetype)initWithDatas:(NSArray <id<ChainedDroplistModelProtocol>> *)datas;


@end
