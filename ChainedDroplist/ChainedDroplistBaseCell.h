//
//  ChainedDroplistBaseCell.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2019/4/11.
//  通用股票持仓下拉列表样式，买入历史记录或卖出持仓展示

#import <UIKit/UIKit.h>
#import "ChainedDroplistDef.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChainedDroplistBaseCell : UITableViewCell <ChainedDroplistCellProtocol>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomSepline;

@end

NS_ASSUME_NONNULL_END
