//
//  ChainedDroplistBaseCell.m
//  ChainedDroplist
//
//  Created by seuzxh@163.com on 2019/4/11.
//

#import "ChainedDroplistBaseCell.h"
#import "ChainedDroplistBaseModel.h"
#import "Masonry.h"

NSString *const kChainedDroplistBaseCellIdentifier = @"ChainedDroplistBaseCellIdentifier";

@implementation ChainedDroplistBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}



#pragma mark - ChainedDroplistCellProtocol
- (void)configCellWithModel:(id<ChainedDroplistModelProtocol>)model
{
    NSAssert([model isKindOfClass:ChainedDroplistBaseModel.class],
             @"model[%@] has the wrong class type", model);
    ChainedDroplistBaseModel *posModel = (ChainedDroplistBaseModel *)model;
    self.bottomSepline.hidden = !posModel.needBottomSepline;
    self.titleLabel.text = posModel.strTitle;
}

#pragma mark - getter
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = UIColor.blackColor;
    }
    
    return _titleLabel;
}

- (UIView *)bottomSepline
{
    if (!_bottomSepline) {
        _bottomSepline = UIView.new;
        
        _bottomSepline.backgroundColor = UIColor.darkGrayColor;
    }
    
    return _bottomSepline;
}

#pragma mark - UI
- (void)setupUI
{
    self.backgroundColor = self.contentView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bottomSepline];
}

- (void)setupConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.width.mas_equalTo(self.contentView);
    }];
    
    [self.bottomSepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}



@end
