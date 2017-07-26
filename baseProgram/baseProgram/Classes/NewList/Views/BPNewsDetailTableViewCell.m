//
//  BPNewsDetailTableViewCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/23.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsDetailTableViewCell.h"

@interface BPNewsDetailTableViewCell()

@property(nonatomic,strong)UILabel *homeLabel;
@property(nonatomic,strong)UIImageView *homeLogo;
@property(nonatomic,strong)UILabel *awayLabel;
@property(nonatomic,strong)UIImageView *awayLogo;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *teamType;
@property(nonatomic,strong)UILabel *tipType ;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *anthorLabel;
@property(nonatomic,strong)UIImageView *newsImage;


@end

@implementation BPNewsDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *homelogo = [UIImageView new];
        [self addSubview:homelogo];
        [homelogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        _homeLogo = homelogo;
        
        UILabel *homeLabel = [UILabel new];
        [self addSubview:homeLabel];
        [homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(homelogo);
            make.left.mas_equalTo(homelogo.mas_right).mas_offset(5);
        }];
        _homeLabel = homeLabel;
        homeLabel.font = [UIFont systemFontOfSize:11];
        homeLabel.textColor = [UIColor blackColor];
        
        UIImageView *awaylogo = [UIImageView new];
        [self addSubview:awaylogo];
        [awaylogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        _awayLogo = awaylogo;
        
        UILabel *awayLabel = [UILabel new];
        [self addSubview:awayLabel];
        [awayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(awaylogo);
            make.right.mas_equalTo(awaylogo.mas_left).mas_offset(-5);
        }];
        _awayLabel = awayLabel;
        awayLabel.font = [UIFont systemFontOfSize:11];
        awayLabel.textColor = [UIColor blackColor];
        
        UIImageView *newImageView = [UIImageView new];
        [self addSubview:newImageView];
        [newImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homelogo.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(100);
        }];
        _newsImage = newImageView;
        
        UILabel *dateLabel = [UILabel new];
        [self addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(newImageView.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(newImageView);
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
        _teamType= teamType;
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
        
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(newImageView);
            make.right.mas_equalTo(newImageView);
        }];
        _titleLabel = titleLabel;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.font = [UIFont systemFontOfSize:22];
        titleLabel.textColor = [UIColor blackColor];
        
        UILabel *contentLabel = [UILabel new];
        [self addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(newImageView);
            make.right.mas_equalTo(newImageView);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15);
        }];
        _contentLabel = contentLabel;
        contentLabel.textAlignment =  NSTextAlignmentLeft;
        contentLabel.numberOfLines = 5;
        contentLabel.adjustsFontSizeToFitWidth = YES;
        contentLabel.font = [UIFont systemFontOfSize:14];
        contentLabel.textColor = [UIColor grayColor];
        
        UILabel *anthorLabel = [UILabel new];
        [self addSubview:anthorLabel];
        [anthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentLabel.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(newImageView);
        }];
        _anthorLabel = anthorLabel;
        anthorLabel.font = [UIFont systemFontOfSize:12];
        anthorLabel.textColor = [UIColor blackColor];
        
    }
    return self;
}

-(void)setDataModel:(BPNewsListModel *)dataModel;
{
    _dataModel = dataModel;
    _homeLabel.text = dataModel.homeName;
    [_homeLogo sd_setImageWithURL:[NSURL URLWithString: dataModel.homeLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _awayLabel.text = dataModel.awayName;
    [_awayLogo sd_setImageWithURL:[NSURL URLWithString: dataModel.awayLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
}

-(void)setTipsModel:(BPNewsListTipsModel *)tipsModel
{
    _tipsModel = tipsModel;
    
    if(_tipsModel.teamTypeId.integerValue == 1)
    {
        _homeLogo.hidden = NO;
        _homeLabel.hidden = NO;
        _awayLogo.hidden = YES;
        _awayLabel.hidden = YES;
    }else{
        _homeLogo.hidden = YES;
        _homeLabel.hidden = YES;
        _awayLogo.hidden = NO;
        _awayLabel.hidden = NO;
    }
    
    if(tipsModel.picUrl.length == 0)
    {
        //没有新闻图片
        _newsImage.hidden = YES;
        [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_homeLogo.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(0);
        }];
        
    }else{
        _newsImage.hidden = NO;
        [_newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_homeLogo.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(20);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(100);
        }];
        //有新闻图片
        [_newsImage sd_setImageWithURL:[NSURL URLWithString: tipsModel.picUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
    }
    _dateLabel.text = tipsModel.publishTime;
    _teamType.text = [NSString stringWithFormat:@"· %@",tipsModel.teamTypeName];
    _tipType.text = [NSString stringWithFormat:@"· %@",tipsModel.tipsTypeName];
    _titleLabel.text = tipsModel.title;
    _contentLabel.text = tipsModel.content;
    _anthorLabel.text = [NSString stringWithFormat:@"爆料员 : %@",tipsModel.authorName];
   
}



@end
