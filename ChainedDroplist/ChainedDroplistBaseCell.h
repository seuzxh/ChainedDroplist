//
//  ChainedDroplistBaseCell.h
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2019/4/11.
//  Basic droplist cell

#import <UIKit/UIKit.h>
#import "ChainedDroplistDef.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChainedDroplistBaseCell : UITableViewCell <ChainedDroplistCellProtocol>

/**
 Base title label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 Cell bottom sepline view
 */
@property (nonatomic, strong) UIView *bottomSepline;

/**
 Setup Cell UI : such as addsubview
 You can overwrite this method to setup your own UI style.
 It will be called in [initWithStyle:reuseIdentifier:] method
 */
- (void)setupUI;

/**
 Setup Cell Constraints
 You can overwrite this method to setup your own UI contraints.
 It will be called in [initWithStyle:reuseIdentifier:] after [self setupUI] method
*/
- (void)setupConstraints;

@end

NS_ASSUME_NONNULL_END
