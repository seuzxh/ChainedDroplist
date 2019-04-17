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
    [self showDroplist:btn];
}

- (void)showDroplist:(UIView *)baseView
{
    [[[[[ChainedDroplistView alloc] initWithConfig:^(ChainedDroplistView *droplist) {
        droplist.hostView = self.view;
        droplist.baseView = baseView;
        droplist.rotationView = nil;
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
    }
    
    return _bottomBtn;
}

- (UIView *)topHostView
{
    if (!_topHostView) {
        _topHostView = [UIView new];
        _topHostView.backgroundColor = [UIColor whiteColor];
    }
    
    return _topHostView;
}

- (UIView *)bottomHostView
{
    if (!_bottomHostView) {
        _bottomHostView = UIView.new;
        _bottomHostView.backgroundColor = [UIColor whiteColor];
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
