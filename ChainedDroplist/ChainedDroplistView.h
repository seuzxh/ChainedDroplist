//
//  ChainedDroplistView.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//  Droplist with UITableView

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
 Datas used for init UITableView datasource
 */
@property (nonatomic, strong) NSArray <id<ChainedDroplistModelProtocol>> *datas;


/**
 用于设置droplist 展示方向：向上 向下
 如果不设置，会基于 baseview 和 hostview 来确认展示方向
 */
@property (nonatomic, assign) EChainedDroplistViewDirection droplistDirection;

/**
 初始化方法

 @param config 用于配置以上定义的 public properties
 
 @return Droplist instance used for chained program
 */
- (instancetype)initWithConfig:(void(^)(ChainedDroplistView *droplist))config;

/**
 用于绑定自定义的 UITableViewCell

 @param config 提供给用户绑定自定义 cell 的 block
 
 @return Droplist instance used for chained program
 */
- (instancetype)registCustomerCellsWithConfig:(void(^)(UITableView *tableView))config;

/**
 Show droplist with animation
 In this method, the datasource&delegate of UITableView will be set

 @return Droplist instance used for chained program
 */
- (instancetype)show;

/**
 Dismiss dorplist
 */
- (void)dismiss;

/**
 Add the block when user click one cell
 The blk won't be called if the usr tap the other place to dismiss the droplist
 
 @param blk Procession after usr select one cell
 */
- (void)processAfterSelected:(void(^)(NSInteger index))blk;

@end
