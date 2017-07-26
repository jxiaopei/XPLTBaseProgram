//
//  BPNewsTipsCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsTipsCell.h"

@interface BPNewsTipsCell()

@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *teamType;
@property(nonatomic,strong)UILabel *tipType ;
@property(nonatomic,strong)UILabel *titleLabel;

@end

@implementation BPNewsTipsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView = [UIView new];
        [self addSubview:lineView];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.alpha = 0.8;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.left.right.mas_equalTo(5);
            make.height.mas_equalTo(0.5);
        }];
        
        UILabel *dateLabel = [UILabel new];
        [self addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lineView.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(15);
        }];
        _dateLabel = dateLabel;
        dateLabel.font = [UIFont systemFontOfSize:11];
        dateLabel.textColor = [UIColor blackColor];
        
        UILabel *teamType = [UILabel new];
        [self addSubview:teamType];
        [teamType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_top);
            make.left.mas_equalTo(dateLabel.mas_right).mas_offset(2);
        }];
        _teamType = teamType;
        teamType.font = [UIFont systemFontOfSize:11];
        teamType.textColor = [UIColor blackColor];
        
        UILabel *tipType = [UILabel new];
        [self addSubview:tipType];
        [tipType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_top);
            make.left.mas_equalTo(teamType.mas_right).mas_offset(2);
        }];
        _tipType = tipType;
        tipType.font = [UIFont systemFontOfSize:11];
        tipType.textColor = [UIColor blackColor];
        
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        _titleLabel = titleLabel;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textColor = [UIColor blackColor];
        
        
    }
    return self;
}

-(void)setTipsModel:(BPNewsListTipsModel *)tipsModel
{
    _tipsModel = tipsModel;
    
    _dateLabel.text = tipsModel.publishTime;
    _teamType.text = [NSString stringWithFormat:@"· %@",tipsModel.teamTypeName];
    _tipType.text = [NSString stringWithFormat:@"· %@",tipsModel.tipsTypeName];
    _titleLabel.text = tipsModel.title;
}


@end
