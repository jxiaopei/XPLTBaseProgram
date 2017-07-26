//
//  BPNewsDetailViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/22.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsDetailViewController.h"
#import "BPNewsDetailTitleModel.h"
#import "BPNewsDetailTableViewCell.h"

@interface BPNewsDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIImageView *homeLogo;
@property(nonatomic,strong)UILabel *homeScore;
@property(nonatomic,strong)UIImageView *awayLogo;
@property(nonatomic,strong)UILabel *awayScore;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)BPNewsDetailTitleModel *titleModel;
@property(nonatomic,strong)UIView *navBar;
@property(nonatomic,strong)NSMutableArray <BPNewsListTipsModel *>*dataSource;

@end

@implementation BPNewsDetailViewController

-(void)setDataModel:(BPNewsListModel *)dataModel
{
    _dataModel = dataModel;
    self.dataSource = [BPNewsListTipsModel mj_objectArrayWithKeyValuesArray:dataModel.tips];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    [self setupTableView];
    [self getData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    
}

-(void)setupTableView
{
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self.tableView registerClass:[BPNewsDetailTableViewCell class] forCellReuseIdentifier:@"NewsDetailCell"];
}

-(void)getData{
    
    NSString *url = [NSString stringWithFormat:@"http://query-api.8win.com/command/execute?command=200001&lotteryType=1&matchId=%@",self.dataModel.matchId];
    [[BPNetRequest getInstance]getDataWithUrl:url parameters:nil success:^(id responseObject) {
        if([responseObject[@"code"]  integerValue] == 0)
        {
            self.titleModel =  [BPNewsDetailTitleModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self setupDataToNavBar];
        }
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
    
}
-(void)setupDataToNavBar
{
    [_homeLogo sd_setImageWithURL:[NSURL URLWithString:_titleModel.homeLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _homeScore.text = _titleModel.homeGoals;
    _titleLabel.text = _titleModel.stageName;
    [_awayLogo sd_setImageWithURL:[NSURL URLWithString:_titleModel.awayLogo] placeholderImage:[UIImage imageNamed:@"占位图"]];
    _awayScore.text = _titleModel.awayGoals;
}

-(void)setupNavigationBar
{
    UIView *navBar = [UIView new];
    navBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:navBar];
    [navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    self.navBar = navBar;
    
    UIView *titleView = [UIView new];
    [navBar addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(navBar);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    UIImageView *homeLogo = [UIImageView new];
    [titleView addSubview:homeLogo];
    [homeLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(20);
    }];
    _homeLogo = homeLogo;
    
    UILabel *homeScore = [UILabel new];
    [titleView addSubview:homeScore];
    [homeScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(homeLogo.mas_right).mas_offset(8);
        make.top.mas_equalTo(homeLogo);
    }];
    _homeScore = homeScore;
    homeScore.textColor = [UIColor whiteColor];
    homeScore.font = [UIFont systemFontOfSize:18];
    
    UILabel *titleLabel = [UILabel new];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(titleView);
        make.width.mas_equalTo(100);
    }];
    _titleLabel = titleLabel;
    titleLabel.adjustsFontSizeToFitWidth = YES;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UIImageView *awayLogo = [UIImageView new];
    [titleView addSubview:awayLogo];
    [awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.mas_equalTo(0);
        make.width.mas_equalTo(20);
    }];
    _awayLogo = awayLogo;
    
    UILabel *awayScore = [UILabel new];
    [titleView addSubview:awayScore];
    [awayScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(awayLogo.mas_left).mas_offset(-8);
        make.top.mas_equalTo(awayLogo);
    }];
    _awayScore = awayScore;
    awayScore.textColor = [UIColor whiteColor];
    awayScore.font = [UIFont systemFontOfSize:18];
    
    UIButton *backBtn = [UIButton new];
    [navBar addSubview:backBtn];
    [backBtn addTarget:self action:@selector(didClickGoBack:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(navBar);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(5, 7.5, 5, 7.5);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPNewsDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsDetailCell" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.tipsModel = self.dataSource[indexPath.row];
    cell.dataModel = self.dataModel;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPNewsListTipsModel *tipsModel = self.dataSource[indexPath.row];
    return tipsModel.rowHeight;
}

-(NSMutableArray <BPNewsListTipsModel *>*)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

-(void)didClickGoBack:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES ];
    self.navigationController.navigationBar.hidden = NO;
}


@end
