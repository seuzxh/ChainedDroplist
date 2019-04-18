//
//  ChainedDroplistCustomerCell.m
//  ChainedDroplist_Example
//
//  Created by seuzxh@163.com on 2019/4/18.
//  Copyright © 2019 seuzxh. All rights reserved.
//

#import "ChainedDroplistCustomerCell.h"
#import "ChainedDroplistCustomerModel.h"
#import "Masonry.h"

@interface ChainedDroplistCustomerCell ()

@property (nonatomic, strong) UILabel *customerLabel;
@property (nonatomic, strong) UILabel *customerDetail;
@property (nonatomic, strong) UIView *customSepline;


@end

@implementation ChainedDroplistCustomerCell


#pragma mark - ChainedDroplistCellProtocol
- (void)configCellWithModel:(id<ChainedDroplistModelProtocol>)model
{
    if (![model isKindOfClass:ChainedDroplistCustomerModel.class]) {
        return;
    }
    
    ChainedDroplistCustomerModel *customerModel = (ChainedDroplistCustomerModel *)model;
    self.customerLabel.text = customerModel.customerTitle;
    self.customerDetail.text = customerModel.customerDetail;
    self.customSepline.hidden = !customerModel.needBottomSepline;
}

#pragma mark - Overwrite UI
- (void)setupUI
{
    self.backgroundColor = self.contentView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.customerLabel];
    [self.contentView addSubview:self.customerDetail];
    [self.contentView addSubview:self.customSepline];
}


- (void)setupConstraints
{
    [self.customSepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).offset(20);
        make.height.mas_equalTo(2);
    }];
    
    [self.customerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(20);
        make.right.mas_equalTo(self.contentView.mas_centerX).offset(-10);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.customerDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-5);
        make.left.mas_equalTo(self.contentView.mas_centerX);
        make.centerY.mas_equalTo(self.customerLabel);
    }];
}

#pragma mark - Lazy load
- (UILabel *)customerLabel
{
    if (!_customerLabel) {
        _customerLabel = [UILabel new];
        _customerLabel.font = [UIFont systemFontOfSize:16];
        _customerLabel.textColor = UIColor.darkTextColor;
        _customerLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _customerLabel;
}

- (UILabel *)customerDetail
{
    if (!_customerDetail) {
        _customerDetail = [UILabel new];
        _customerDetail.adjustsFontSizeToFitWidth = YES;
        _customerDetail.font = [UIFont systemFontOfSize:15];
        _customerDetail.textColor = [UIColor lightGrayColor];
        _customerDetail.textAlignment = NSTextAlignmentLeft;
    }
    return _customerDetail;
}

- (UIView *)customSepline
{
    if (!_customSepline) {
        _customSepline = [UIView new];
        _customSepline.backgroundColor = UIColor.redColor;
    }
    
    return _customSepline;
}

@end
