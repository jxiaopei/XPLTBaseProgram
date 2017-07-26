//
//  BPNewsListCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsListCell.h"
#import "BPNewsTipsCell.h"
#import "BPNewsShowMoreCell.h"
#import "BPNewsDetailViewController.h"

@interface BPNewsListCell()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UILabel *homeLabel;
@property(nonatomic,strong)UIImageView *homeLogo;
@property(nonatomic,strong)UILabel *contextLabel;
@property(nonatomic,strong)UILabel *awayLabel;
@property(nonatomic,strong)UIImageView *awayLogo;
@property(nonatomic,strong)UILabel *leagueNameLabel;
@property(nonatomic,strong)UIView *noNewsImageView;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *teamType;
@property(nonatomic,strong)UILabel *tipType ;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *anthorLabel;
@property(nonatomic,strong)UIView *newsImageView;
@property(nonatomic,strong)UIImageView *newsImage;
@property(nonatomic,strong)UILabel *dateLabel1;
@property(nonatomic,strong)UILabel *teamType1;
@property(nonatomic,strong)UILabel *tipType1;
@property(nonatomic,strong)UILabel *titleLabel1;




@end

@implementation BPNewsListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *heLineView = [UIView new];
        heLineView.alpha = 0.6;
        [self addSubview:heLineView];
        [heLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        heLineView.backgroundColor = [UIColor grayColor];
        
        UILabel *homeLabel = [UILabel new];
        [self addSubview:homeLabel];
        [homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(heLineView.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(10);
        }];
        _homeLabel = homeLabel;
        homeLabel.font = [UIFont systemFontOfSize:11];
        homeLabel.textColor = [UIColor blackColor];
        
        UIImageView *homeLogo = [UIImageView new];
        [self addSubview:homeLogo];
        [homeLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homeLabel);
            make.left.mas_equalTo(homeLabel.mas_right).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        _homeLogo = homeLogo;
        
        UILabel *contextLabel = [UILabel new];
        [self addSubview:contextLabel];
        [contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homeLabel);
            make.left.mas_equalTo(homeLogo.mas_right).mas_offset(5);
        }];
        _contextLabel = contextLabel;
        contextLabel.font = [UIFont systemFontOfSize:11];
        contextLabel.textColor = [UIColor blackColor];
        
        UILabel *awayLabel = [UILabel new];
        [self addSubview:awayLabel];
        [awayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homeLabel);
            make.left.mas_equalTo(contextLabel.mas_right).mas_offset(5);
        }];
        _awayLabel = awayLabel;
        awayLabel.font = [UIFont systemFontOfSize:11];
        awayLabel.textColor = [UIColor blackColor];
        
        UIImageView *awayLogo = [UIImageView new];
        [self addSubview:awayLogo];
        [awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homeLabel);
            make.left.mas_equalTo(awayLabel.mas_right).mas_offset(5);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        _awayLogo = awayLogo;
        
        UILabel *leagueNameLabel = [UILabel new];
        [self addSubview:leagueNameLabel];
        [leagueNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homeLabel);
            make.right.mas_equalTo(-15);
        }];
        _leagueNameLabel = leagueNameLabel;
        leagueNameLabel.font = [UIFont systemFontOfSize:11];
        leagueNameLabel.textColor = [UIColor blackColor];
        
        //没有新闻图片
        UIView *noNewsImageView = [UIView new];
        [self addSubview:noNewsImageView];
        [noNewsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(homeLabel.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(150);
        }];
//        noNewsImageView.backgroundColor = [UIColor yellowColor];
        _noNewsImageView = noNewsImageView;
        
        UILabel *dateLabel = [UILabel new];
        [noNewsImageView addSubview:dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(homeLabel.mas_bottom).mas_offset(20);
            make.left.mas_equalTo(15);
        }];
        _dateLabel = dateLabel;
        dateLabel.font = [UIFont systemFontOfSize:11];
        dateLabel.textColor = [UIColor blackColor];
        
        UILabel *teamType = [UILabel new];
        [noNewsImageView addSubview:teamType];
        [teamType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_top);
            make.left.mas_equalTo(dateLabel.mas_right).mas_offset(2);
        }];
        _teamType= teamType;
        teamType.font = [UIFont systemFontOfSize:11];
        teamType.textColor = [UIColor blackColor];
        
        UILabel *tipType = [UILabel new];
        [noNewsImageView addSubview:tipType];
        [tipType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_top);
            make.left.mas_equalTo(teamType.mas_right).mas_offset(2);
        }];
        _tipType = tipType;
        tipType.font = [UIFont systemFontOfSize:11];
        tipType.textColor = [UIColor blackColor];
        
        UILabel *titleLabel = [UILabel new];
        [noNewsImageView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_bottom).mas_offset(15);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
        }];
        _titleLabel = titleLabel;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.textColor = [UIColor blackColor];
        
        UIView *verLineView = [UIView new];
        [noNewsImageView addSubview:verLineView];
        verLineView.backgroundColor = [UIColor redColor];
        [verLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15);
            make.left.mas_equalTo(20);
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(60);
        }];
        
        UILabel *contentLabel = [UILabel new];
        [noNewsImageView addSubview:contentLabel];
        [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(verLineView.mas_right).mas_offset(5);
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(15);
        }];
        _contentLabel = contentLabel;
        contentLabel.textAlignment =  NSTextAlignmentLeft;
        contentLabel.numberOfLines = 4;
        contentLabel.font = [UIFont systemFontOfSize:10];
        contentLabel.textColor = [UIColor grayColor];
        
        UILabel *anthorLabel = [UILabel new];
        [noNewsImageView addSubview:anthorLabel];
        [anthorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(contentLabel.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(verLineView.mas_right).mas_offset(5);
        }];
        _anthorLabel = anthorLabel;
        anthorLabel.font = [UIFont systemFontOfSize:10];
        anthorLabel.textColor = [UIColor blackColor];
        
        
        //有新闻图片
        UIView *newsImageView = [UIView new];
        [self addSubview:newsImageView];
        [newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(homeLabel.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(150);
        }];
//        newsImageView.backgroundColor = [UIColor blueColor];
        _newsImageView = newsImageView;
        
        UIImageView *newsImage = [UIImageView new];
        [newsImageView addSubview:newsImage];
        [newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(homeLogo.mas_bottom).mas_offset(8);
            make.height.mas_equalTo(142);
        }];
        _newsImage = newsImage;
        //灰色view
        UIView *maskView = [UIView new];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.8;
        [newsImageView addSubview:maskView];
        [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(70);
            make.bottom.mas_equalTo(newsImage.mas_bottom);
        }];
        
        UILabel *dateLabel1 = [UILabel new];
        [newsImageView addSubview:dateLabel1];
        [dateLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(maskView.mas_top).mas_offset(15);
            make.left.mas_equalTo(maskView.mas_left).mas_offset(15);
        }];
        _dateLabel1 = dateLabel1;
        dateLabel1.font = [UIFont systemFontOfSize:11];
        dateLabel1.textColor = [UIColor whiteColor];
        
        UILabel *teamType1 = [UILabel new];
        [newsImageView addSubview:teamType1];
        [teamType1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel1);
            make.left.mas_equalTo(dateLabel1.mas_right).mas_offset(2);
        }];
        _teamType1 = teamType1;
        teamType1.font = [UIFont systemFontOfSize:11];
        teamType1.textColor = [UIColor whiteColor];
        
        UILabel *tipType1 = [UILabel new];
        [newsImageView addSubview:tipType1];
        [tipType1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel1);
            make.left.mas_equalTo(teamType1.mas_right).mas_offset(2);
        }];
        _tipType1 = tipType1;
        tipType1.font = [UIFont systemFontOfSize:11];
        tipType1.textColor = [UIColor whiteColor];
        
        UILabel *titleLabel1 = [UILabel new];
        [newsImageView addSubview:titleLabel1];
        [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel1.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(maskView.mas_left).mas_offset(15);
            make.right.mas_equalTo(maskView.mas_right).mas_equalTo(-15);
        }];
        _titleLabel1 = titleLabel1;
        titleLabel1.adjustsFontSizeToFitWidth = YES;
        titleLabel1.font = [UIFont systemFontOfSize:18];
        titleLabel1.textColor = [UIColor whiteColor];
        
        _tableView = [UITableView new];
        [self addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(noNewsImageView.mas_bottom);
            make.right.left.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        [self.tableView registerClass:[BPNewsTipsCell class] forCellReuseIdentifier:@"NewsTipsCell"];
        [self.tableView registerClass:[BPNewsShowMoreCell class] forCellReuseIdentifier:@"NewsShowMoreCell"];
    }
    return self;
}

-(void)setDataModel:(BPNewsListModel *)dataModel
{
    _dataModel = dataModel;
  
    _homeLabel.text = dataModel.homeName;
    [_homeLogo sd_setImageWithURL:[NSURL URLWithString: dataModel.homeLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _contextLabel.text = [dataModel.matchBeginTime substringFromIndex:11];
    _awayLabel.text = dataModel.awayName;
    [_awayLogo sd_setImageWithURL:[NSURL URLWithString: dataModel.awayLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _leagueNameLabel.text = [NSString  stringWithFormat:@"%@ · %@",dataModel.matchNo,dataModel.leagueName];
    BPNewsListTipsModel *tipsModel = [BPNewsListTipsModel mj_objectWithKeyValues: dataModel.tips[0] ];

    if(tipsModel.picUrl.length == 0)
    {
        self.noNewsImageView.hidden = NO;
        self.newsImageView.hidden = YES;
        //没有新闻图片
        _dateLabel.text = tipsModel.publishTime;
        _teamType.text = [NSString stringWithFormat:@"· %@",tipsModel.teamTypeName];
        _tipType.text = [NSString stringWithFormat:@"· %@",tipsModel.tipsTypeName];
        _titleLabel.text = tipsModel.title;
        _contentLabel.text = tipsModel.content;
        _anthorLabel.text = [NSString stringWithFormat:@"爆料员 : %@",tipsModel.authorName];

    }else{
        self.noNewsImageView.hidden = YES;
        self.newsImageView.hidden = NO;
        //有新闻图片
        [_newsImage sd_setImageWithURL:[NSURL URLWithString: tipsModel.picUrl] placeholderImage:[UIImage imageNamed:@"占位图"]];
        _dateLabel1.text = tipsModel.publishTime;
        _teamType1.text = [NSString stringWithFormat:@"· %@",tipsModel.teamTypeName];
        _tipType1.text = [NSString stringWithFormat:@"· %@",tipsModel.tipsTypeName];
        _titleLabel1.text = tipsModel.title;
    }
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_dataModel.isShowMore){
        return  _dataModel.tips.count -1;
    }else{
        return 2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_dataModel.isShowMore && indexPath.row == 1)
    {
        BPNewsShowMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsShowMoreCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        BPNewsTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTipsCell" forIndexPath:indexPath];
        cell.tipsModel = [BPNewsListTipsModel mj_objectWithKeyValues:_dataModel.tips[indexPath.row + 1]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_dataModel.isShowMore && indexPath.row == 1)
    {
        return 30;
        
    }else{
        
        return 70;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!_dataModel.isShowMore && indexPath.row == 1)
    {
        _dataModel.isShowMore = YES;
        [self.tableView reloadData];
        _refreshBlock();
    }else{
        _pushVCBlock();
    }
}



@end
