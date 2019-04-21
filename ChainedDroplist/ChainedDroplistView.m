//
//  ChainedDroplistView.m
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2017/11/29.
//

#import "ChainedDroplistView.h"
#import "ChainedDroplistDataSource.h"

#import "ChainedDroplistPrivateDef.h"
#import "ChainedDroplistDef.h"

#import "Masonry.h"


NSInteger const kChainedDroplistViewTag = 111;

@interface ChainedDroplistView()<UITableViewDelegate, UIGestureRecognizerDelegate>{
    void(^_processBlk)(NSInteger index);
}

@property (nonatomic, strong) UIView *bottomShadowView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ChainedDroplistDataSource *dataSource;

@end

@implementation ChainedDroplistView

#pragma mark - Life Cycle
- (void)dealloc
{
    CDLebugLog(@"[%@] dealloc", self);
}

#pragma mark - Public Api

- (instancetype)initWithConfig:(void(^)(ChainedDroplistView *droplist))config
{
    self = [super init];
    if (self) {
        [self setupDefaults];
        
        if (config) {
            config(self);
        }
        
        self.dataSource = [[ChainedDroplistDataSource alloc] initWithDatas:self.datas];
        if ( self.droplistDirection == EChainedDroplistViewDirectionNone ) {
            [self calculateDirection];
        }
        
        [self addTapGesture];
        
        [self setupUI];
        [self setupConstraints];
        [self layoutIfNeeded];
    }
    
    return self;
}

- (instancetype)registCustomerCellsWithConfig:(void (^)(UITableView *))config
{
    if (config) {
        config(self.tableView);
    }
    
    return self;
}

- (instancetype)show
{
    if (!self.tableView.delegate) {
        /*
         延迟设置 delegate 和 datasource，防止用户通过 registCustomerCellsWithConfig 注册自定义 cells
         */
        self.tableView.delegate = self;
        self.tableView.dataSource = self.dataSource;
    }
    
    if (_processBlk) {
        // it may be called multitimes
        _processBlk = nil;
    }
    
    NSUInteger nRowCnt = [self calculateVisibleRows];
    CGFloat tableHeight = self.cellHeight * nRowCnt;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableHeight);
    }];
    
    [self bringSubviewToFront:self.tableView];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [self layoutIfNeeded];
                         if (self.rotationView) {
                             self.rotationView.transform = CGAffineTransformMakeRotation(M_PI);
                         }
                     } completion:^(BOOL finished) {
                         self.tableView.userInteractionEnabled = YES;
                         self.bottomShadowView.hidden = NO;
                     }];
    
    return  self;
}

- (void)processAfterSelected:(void(^)(NSInteger index))blk
{
    if (blk) {
        _processBlk = [blk copy];
    }
}

- (void)dismiss
{
    [self dismissDroplistWithResult:-1];
}

#pragma mark - UI
- (void)setupUI
{
    if (!self.hostView) {
        UIWindow *keyWin = [UIApplication.sharedApplication keyWindow];
        self.hostView = keyWin;
    }
    
    UIView *checkView = [self.hostView viewWithTag:kChainedDroplistViewTag];
    if (checkView && [checkView isKindOfClass:self.class]) {
        ChainedDroplistView *lastView = (ChainedDroplistView *)checkView;
        [lastView removeFromSuperview];
    }
    
    [self.hostView addSubview:self];
    [self addSubview:self.tableView];
    [self addSubview:self.bottomShadowView];
    
    self.tag = kChainedDroplistViewTag;
    self.tableView.userInteractionEnabled = NO;
}

- (void)setupConstraints
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.hostView);
    }];

    CGPoint baseViewOrigin = [self.baseView convertPoint:CGPointZero toView:self];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.baseView);
        make.left.mas_equalTo(self).offset(baseViewOrigin.x);
        switch (self.droplistDirection) {
            case EChainedDroplistViewDirectionUp:
//                make.bottom.mas_equalTo(self.baseView.mas_top).offset(baseViewOrigin.y);
                make.bottom.mas_equalTo(self.baseView.mas_top);

                break;
            case EChainedDroplistViewDirectionDown:
//                make.top.mas_equalTo(self).offset(baseViewOrigin.y+CGRectGetHeight(self.baseView.frame));
                make.top.mas_equalTo(self.baseView.mas_bottom);

                break;
            case EChainedDroplistViewDirectionNone:
                break;
        }
        
        make.height.mas_equalTo(0);
    }];
    
    [self.bottomShadowView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.mas_equalTo(self.tableView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(-1);
    }];
}

#pragma mark - Private Api
- (void)setupDefaults
{
    self.cellHeight = 55;
    self.droplistDirection = EChainedDroplistViewDirectionNone;
}

- (void)addTapGesture
{   
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    dismissTap.delegate = self;
    [self addGestureRecognizer:dismissTap];
}

- (void)dismissDroplistWithResult:(NSInteger)selIndex
{
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    if (self.rotationView) {
        // 为了原路径旋转返回
        self.rotationView.transform = CGAffineTransformMakeRotation(M_PI-0.1);
    }
    
    self.bottomShadowView.alpha = 0;
    self.bottomShadowView.hidden = YES;
    
    [UIView animateWithDuration:0.3f animations:^{
        [self layoutIfNeeded];
        if (self.rotationView) {
            self.rotationView.transform = CGAffineTransformIdentity;
        }
        
    } completion:^(BOOL finished) {
        if (selIndex >= 0) {
            self->_processBlk ? self->_processBlk(selIndex) : nil;
        } else {
            self->_processBlk = nil; // do nothing
        }
        
        [self removeFromSuperview];
    }];
}


/**
 根据hostview 的高度，和 droplist top 计算当前 droplist 需要展示的方向
 默认展示展示五行，如果行数不够会主动 -1
 
 @return 可以展示的最大行数
 */
- (NSUInteger)calculateVisibleRows
{
    CGPoint basePoint = CGPointZero;
    CGFloat visibleHeight = 0;
    switch (self.droplistDirection) {
        case EChainedDroplistViewDirectionUp: // 向上展示
            basePoint = [self.baseView convertPoint:CGPointZero toView:self.hostView]; // 以 baseView 顶部为起点
            visibleHeight = basePoint.y;
            break;
        case EChainedDroplistViewDirectionDown: // 向下展示
            basePoint = [self.baseView convertPoint:CGPointMake(0, CGRectGetHeight(self.baseView.frame)) toView:self.hostView]; // 以 baseView 底部为起点
            visibleHeight = CGRectGetHeight(self.hostView.frame) - basePoint.y;
            break;
        case EChainedDroplistViewDirectionNone:
            break;
    }
    NSUInteger rowCnt = self.datas.count > 5 ? 5 : self.datas.count;
    CGFloat tableHeight = self.cellHeight * rowCnt;
    if (visibleHeight >= tableHeight) {
        return rowCnt;
    }
    
    while (visibleHeight < tableHeight) {
        rowCnt -- ;
        tableHeight = self.cellHeight * rowCnt;
        if (rowCnt < 1) {
            CDLebugLog(@"There is no space 4 down direction,will show up direction");
            // 底部已经无展示空间，顶部也无展示空间
            NSAssert(self.droplistDirection == EChainedDroplistViewDirectionUp, @"Plz check your hostview");
            break;
        }
    }
    
    return rowCnt;
}

/**
 根据 baseView 在 hostview 中的上下间距来计算
 */
- (void)calculateDirection
{
    CGFloat hostHeight = CGRectGetHeight(self.hostView.frame);
    CGPoint baseViewTopPoint = [self.baseView convertPoint:CGPointZero toView:self.hostView]; // 以 baseView 顶部为起点
    CGPoint baseViewBottomPoint = [self.baseView convertPoint:CGPointMake(0, CGRectGetHeight(self.baseView.frame)) toView:self.hostView]; // 以 baseView 底部为起点

    self.droplistDirection = (hostHeight - baseViewBottomPoint.y) > baseViewTopPoint.y ? EChainedDroplistViewDirectionDown : EChainedDroplistViewDirectionUp;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.tableView]) {
        return NO;
    }

    return YES;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSAssert(indexPath.row < self.datas.count,
             @"Select row[%@] beyonds the max count[%@] of datas",
             @(indexPath.row), @(self.datas.count));
    
    NSInteger index = indexPath.row;
    [self dismissDroplistWithResult:index];
}

#pragma mark - Lazy Load

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _tableView;
}
- (UIView *)bottomShadowView
{
    if (!_bottomShadowView) {
        _bottomShadowView = UIView.new;
        _bottomShadowView.backgroundColor = UIColor.grayColor;
        _bottomShadowView.clipsToBounds = NO;
        _bottomShadowView.layer.shadowColor = UIColor.blackColor.CGColor;
        _bottomShadowView.layer.shadowOpacity = 0.2f;
        _bottomShadowView.layer.shadowOffset = CGSizeMake(0, 4);
        _bottomShadowView.hidden = YES;
    }
    
    return _bottomShadowView;
}

@end
