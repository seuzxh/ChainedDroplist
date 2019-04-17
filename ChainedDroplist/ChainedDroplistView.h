//
//  ChainedDroplistView.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//  下拉列表 droplist tableview 实例

#import <UIKit/UIKit.h>
#import "ChainedDroplistDef.h"

@class BFTask, ChainedDroplistDataSource;
@interface ChainedDroplistView : UIView

/**
 用于展示的 tableview
 */
@property (nonatomic, strong, readonly) UITableView *tableView;

/**
用于决定 droplist 的宽度+top位置
 */
@property (nonatomic, weak) UIView *baseView;

/**
 点击展示 droplist 时需要旋转的view，如 icon 等
 */
@property (nonatomic, weak) UIView *rotationView;

/**
 droplist 的cell height
 default : 55
*/
@property (nonatomic, assign) CGFloat cellHeight;

/**
 展示 droplist 的 containerview
 nil：则为 UIWindow
 */
@property (nonatomic, weak)   UIView *hostView;

/**
 用于设置 UITableView 的 datasource
 */
@property (nonatomic, strong) ChainedDroplistDataSource *dataSource;

/**
 用于设置droplist 展示方向：向上 向下
 如果不设置，会基于 baseview 和 hostview 来确认展示方向
 */
@property (nonatomic, assign) EChainedDroplistViewDirection droplistDirection;

/**
 初始化方法

 @param config 用于配置以上定义的 public properties
 @return droplist 实例
 */
- (instancetype)initWithConfig:(void(^)(ChainedDroplistView *droplist))config;

/**
 用于绑定自定义的 UITableViewCell

 @param config 提供给用户绑定自定义 cell 的 block
 @return 用于链式编程的 self
 */
- (instancetype)registCustomerCellsWithConfig:(void(^)(UITableView *tableView))config;

/**
 展示 droplist，该方法中才会设置 tableview datasource&delegate

 @return 用于异步编程的 BFTask
 */
- (BFTask *)show;

@end
