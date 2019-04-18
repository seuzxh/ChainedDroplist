//
//  ChainedDroplistDataSource.m
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//

#import "ChainedDroplistDataSource.h"

#import "ChainedDroplistPrivateDef.h"
#import "ChainedDroplistDef.h"

@interface ChainedDroplistDataSource()

@property (nonatomic, strong) NSArray <id<ChainedDroplistModelProtocol>> *cellDatas;

@end

@implementation ChainedDroplistDataSource

- (void)dealloc
{
    CDLebugLog(@"[%@] dealloc", self);
}

- (instancetype)initWithDatas:(NSArray <id<ChainedDroplistModelProtocol>> *)datas
{
    self = [super init];
    if (self) {
        self.cellDatas = datas;
    }
    
    return self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDatas.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger index = indexPath.row;
    NSAssert(index < self.cellDatas.count, @"index[%@] beyonds the max count[%@] of datas", @(index), @(self.cellDatas.count));
    id<ChainedDroplistModelProtocol> model = self.cellDatas[index];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:model.strCellIdentifier];
    NSAssert([cell conformsToProtocol:@protocol(ChainedDroplistCellProtocol)],
             @"cell[%@] from identifier[%@] must conforms protocol [%@]",
             cell, model.strCellIdentifier, NSStringFromProtocol(@protocol(ChainedDroplistCellProtocol)));
    UITableViewCell <ChainedDroplistCellProtocol> * droplistCell = (UITableViewCell <ChainedDroplistCellProtocol> *)cell;
    
    if ([droplistCell respondsToSelector:@selector(configCellWithModel:)]) {
        [droplistCell configCellWithModel:model];
    }
    
    return droplistCell;
}

@end
