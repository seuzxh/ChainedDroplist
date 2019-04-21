//
//  ChainedDroplistDef.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//

#ifndef ChainedDroplistDef_h
#define ChainedDroplistDef_h


/**
 Droplist 展示的方向

 - EChainedDroplistViewDirectionNone: 初始未知方向
 - EChainedDroplistViewDirectionDown: 向下展示
 - EChainedDroplistViewDirectionUp: 向上展示
 */
typedef NS_ENUM(NSUInteger, EChainedDroplistViewDirection) {
    EChainedDroplistViewDirectionNone,
    EChainedDroplistViewDirectionDown,
    EChainedDroplistViewDirectionUp
    
};

@protocol ChainedDroplistModelProtocol;
@protocol  ChainedDroplistCellProtocol <NSObject>

/**
 用于刷新自定义cell的protocol接口

 @param model 自定义的 cell model
 */
- (void)configCellWithModel:(id<ChainedDroplistModelProtocol>)model;

@end

/**
 Customer cell must confirm this protol
 UITableView delegate will find cell identifier with this protocol
 */
@protocol ChainedDroplistModelProtocol <NSObject>

@required

/**
 自定义的 cell 绑定的 CellIdentifier
 */
@property (nonatomic, copy) NSString *strCellIdentifier;

@optional

/**
 是否需要展示下划线
 */
@property (nonatomic, assign) BOOL needBottomSepline;

@end

#endif /* ChainedDroplistDef_h */
