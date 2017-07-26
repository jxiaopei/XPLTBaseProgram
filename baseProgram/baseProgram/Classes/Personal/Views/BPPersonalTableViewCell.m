//
//  BPPersonalTableViewCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/24.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPPersonalTableViewCell.h"

@interface BPPersonalTableViewCell()



@end

@implementation BPPersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *icon = [UIImageView new];
        [self addSubview:icon];
        _icon = icon;
        [icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(20);
            make.centerY.mas_equalTo(self);
            make.height.width.mas_equalTo(20);
        }];
        
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(icon.mas_right).mas_offset(10);
            make.centerY.mas_equalTo(self);
        }];
        titleLabel.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

@end
