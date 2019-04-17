//
//  TestChainedDroplistViewController.m
//  ChainedDroplist
//
//  Created by seuzxh on 04/16/2019.
//  Copyright (c) 2019 seuzxh. All rights reserved.
//

#import "TestChainedDroplistViewController.h"

#import "ChainedDroplistView.h"
#import "ChainedDroplistDataSource.h"
#import "ChainedDroplistBaseCell.h"
#import "ChainedDroplistBaseModel.h"
#import "ChainedDroplistDef.h"

#import "Bolts.h"
#import "Masonry.h"


@interface TestChainedDroplistViewController ()

@property (nonatomic, strong) UIView *topHostView;
@property (nonatomic, strong) UIView *bottomHostView;


@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIButton *bottomBtn;


@end

@implementation TestChainedDroplistViewController

#pragma mark - Lify Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setupTestUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
#pragma mark - Tap Action
- (void)tapBtn:(UIButton *)btn
{
    UIView *iconImg = [btn viewWithTag:100];
    [self showDroplist:btn icon:iconImg hostView:self.view];
}

- (void)tapBtnInHostView:(UIButton *)btn
{
    UIView *hostView = btn.superview == self.topHostView ? self.topHostView : self.bottomHostView;
    [self showDroplist:btn icon:nil hostView:hostView];
    
}

- (void)showDroplist:(UIView *)baseView icon:(UIView *)icon hostView:(UIView *)hostView
{
    [[[[[ChainedDroplistView alloc] initWithConfig:^(ChainedDroplistView *droplist) {
        droplist.hostView = self.view;
        droplist.baseView = baseView;
        droplist.rotationView = icon;
        /* droplist.cellHeight = 60; use default height */
        droplist.dataSource = [self createDataSourceWithDatas:[self createTestDatas]];
    }] registCustomerCellsWithConfig:^(UITableView *tableView) {
        [tableView registerClass:ChainedDroplistBaseCell.class forCellReuseIdentifier:kChainedDroplistBaseCellIdentifier];
    }] show] continueWithSuccessBlock:^id _Nullable(BFTask * _Nonnull tSelIndex) {
        NSInteger selectIndex = [tSelIndex.result integerValue];
        NSLog(@"U select index[%@]", @(selectIndex));
        
        return nil;
    }];
    
}


#pragma mark - Lazy load
- (UIButton *)topBtn
{
    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_topBtn setTitle:@"Droplist will show downward" forState:(UIControlStateNormal)];
        _topBtn.backgroundColor = [UIColor orangeColor];
        [_topBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _topBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_topBtn addTarget:self action:@selector(tapBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"droplistTestIcon_down"]];
        icon.tag = 100;
        [_topBtn addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_topBtn);
            make.right.mas_equalTo(_topBtn).offset(-20);
        }];
    }
    
    return _topBtn;
}

- (UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _bottomBtn.backgroundColor = [UIColor orangeColor];
        [_bottomBtn setTitle:@"Droplist will show upward" forState:(UIControlStateNormal)];
        [_bottomBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_bottomBtn addTarget:self action:@selector(tapBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"droplistTestIcon_up"]];
        icon.tag = 100;
        [_bottomBtn addSubview:icon];
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(_bottomBtn);
            make.right.mas_equalTo(_bottomBtn).offset(-20);
        }];
    }
    
    return _bottomBtn;
}

- (UIView *)topHostView
{
    if (!_topHostView) {
        _topHostView = [UIView new];
        _topHostView.backgroundColor = [UIColor whiteColor];
        
        UIButton *subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        subBtn.backgroundColor = [UIColor blueColor];
        [subBtn setTitle:@"Droplist will auto adjust visible cell count" forState:(UIControlStateNormal)];
        [subBtn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        subBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        /*
         in this case you will see if the space between hostView&baseView is less than 5 cells' height, the droplist will decrease the visible quantity automatically until the cells can be shown in the space between
         */
        [subBtn addTarget:self action:@selector(tapBtnInHostView:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_topHostView addSubview:subBtn];
        [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_topHostView);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(_topHostView).offset(-10);
            make.top.mas_equalTo(_topHostView).offset(30);
        }];
    }
    
    return _topHostView;
}

- (UIView *)bottomHostView
{
    if (!_bottomHostView) {
        _bottomHostView = UIView.new;
        _bottomHostView.backgroundColor = [UIColor whiteColor];
        
        // TODO: Add custom cells
    }
    return _bottomHostView;
}

- (NSArray <id <ChainedDroplistModelProtocol> > *)createTestDatas
{
    NSMutableArray *tmp = @[].mutableCopy;
    
    for (int i = 0; i < 10; i++) {
        ChainedDroplistBaseModel *model = [ChainedDroplistBaseModel new];
        model.needBottomSepline = i != 9;
        model.strTitle = [NSString stringWithFormat:@"test cell title [%@]", @(i)];
        [tmp addObject:model];
    }
    
    return tmp;
}

- (ChainedDroplistDataSource *)createDataSourceWithDatas:(NSArray <id <ChainedDroplistModelProtocol> > *)datas
{
    ChainedDroplistDataSource *dataSource = ChainedDroplistDataSource.new;
    dataSource.cellDatas = datas;

    return dataSource;
}

#pragma mark - UI

- (void)setupTestUI
{
    self.view.backgroundColor = UIColor.lightGrayColor;
    [self.view addSubview:self.topBtn];
    [self.view addSubview:self.bottomBtn];
    [self.view addSubview:self.topHostView];
    [self.view addSubview:self.bottomHostView];
    
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(self.view).offset(60);
        make.width.mas_equalTo(self.view).offset(-10); // 左右各5
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.height.mas_equalTo(self.topBtn);
        make.bottom.mas_equalTo(self.view).offset(-60);
        make.width.mas_equalTo(self.view).offset(-10);
    }];
    
    [self.topHostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topBtn.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.view.mas_centerY).offset(-5);
        make.width.mas_equalTo(self.view).offset(-10);
    }];
    
    [self.bottomHostView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view).offset(-10);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_centerY).offset(5);
        make.bottom.mas_equalTo(self.bottomBtn.mas_top).offset(-5);
    }];
}


@end
