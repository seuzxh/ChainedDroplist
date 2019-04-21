//
//  TestChainedDroplistViewController.m
//  ChainedDroplist
//
//  Created by seuzxh on 04/16/2019.
//  Copyright (c) 2019 seuzxh. All rights reserved.
//

#import "TestChainedDroplistViewController.h"

#import "ChainedDroplistView.h"
#import "ChainedDroplistBaseCell.h"
#import "ChainedDroplistBaseModel.h"
#import "ChainedDroplistDef.h"

#import "ChainedDroplistCustomerCell.h"
#import "ChainedDroplistCustomerModel.h"

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
    BOOL isTopHostView = btn.superview == self.topHostView;
    if (isTopHostView) {
        [self showDroplist:btn icon:nil hostView:self.topHostView];
    } else {
        [self showCustomerDroplsit:btn hostView:self.bottomHostView];
    }
    
}

- (void)showDroplist:(UIView *)baseView icon:(UIView *)icon hostView:(UIView *)hostView
{
    [[[[[ChainedDroplistView alloc] initWithConfig:^(ChainedDroplistView *droplist) {
        droplist.hostView = hostView;
        droplist.baseView = baseView;
        droplist.rotationView = icon;
        /* droplist.cellHeight = 60; use default height */
        droplist.datas = [self createTestDatas];
    }] registCustomerCellsWithConfig:^(UITableView *tableView) {
        [tableView registerClass:ChainedDroplistBaseCell.class forCellReuseIdentifier:kChainedDroplistBaseCellIdentifier];
    }] show] processAfterSelected:^(NSInteger index) {
        NSLog(@"U have selected index -> [%@]", @(index));
    }];
     
    
}

- (void)showCustomerDroplsit:(UIView *)baseView hostView:(UIView *)hostView
{
    [[[[[ChainedDroplistView alloc] initWithConfig:^(ChainedDroplistView *droplist) {
        droplist.hostView = hostView;
        droplist.baseView = baseView;
        droplist.rotationView = nil;
        droplist.cellHeight = 60; /*  Customer cell height */
        droplist.datas = [self createTestCustomerDatas];
    }] registCustomerCellsWithConfig:^(UITableView *tableView) {
        //  Regist customer cells
        [tableView registerClass:ChainedDroplistCustomerCell.class forCellReuseIdentifier:kChainedDroplistCustomerCellIdentifier];
    }] show] processAfterSelected:^(NSInteger index) {
        NSLog(@"U have selected index -> [%@]", @(index));
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
        subBtn.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        [subBtn setTitle:@"Droplist will auto adjust visible cell count" forState:(UIControlStateNormal)];
        [subBtn setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
        subBtn.titleLabel.font = [UIFont systemFontOfSize:16];
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
        
        UIButton *subBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        subBtn.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        [subBtn setTitle:@"Droplist will use customer cells" forState:(UIControlStateNormal)];
        [subBtn setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
        subBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        /*
         in this case you will see if the space between hostView&baseView is less than 5 cells' height, the droplist will decrease the visible quantity automatically until the cells can be shown in the space between
         */
        [subBtn addTarget:self action:@selector(tapBtnInHostView:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_bottomHostView addSubview:subBtn];
        [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(_bottomHostView);
            make.height.mas_equalTo(60);
            make.width.mas_equalTo(_bottomHostView).offset(-10);
            make.bottom.mas_equalTo(_bottomHostView).offset(-30);
        }];
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

- (NSArray <id <ChainedDroplistModelProtocol> > *)createTestCustomerDatas
{
    NSMutableArray *tmp = @[].mutableCopy;
    
    for (int i = 0; i < 10; i++) {
        ChainedDroplistCustomerModel *model = [ChainedDroplistCustomerModel new];
        model.needBottomSepline = i != 9;
        model.strTitle = [NSString stringWithFormat:@"test cell title [%@]", @(i)];
        model.customerTitle = @"Customer cell title";
        model.customerDetail = [NSString stringWithFormat:@"Detail info with index [%@]", @(i)];
        [tmp addObject:model];
    }
    
    return tmp;
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
