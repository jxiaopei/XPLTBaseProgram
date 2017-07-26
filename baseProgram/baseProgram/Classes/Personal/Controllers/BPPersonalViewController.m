//
//  PBPersonalViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/24.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPPersonalViewController.h"
#import "BPLoginViewController.h"
#import "BPPersonalTableViewCell.h"
#import "BPSettingViewController.h"

@interface BPPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArr;
@property(nonatomic,strong)UIButton *loginBtn;

@end

@implementation BPPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    [self setupTableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *lastUser = [[NSUserDefaults standardUserDefaults]objectForKey:@"lastUser"];
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    BPUserModel *userModel = nil;
    if([cache containsObjectForKey:lastUser])
    {
       userModel = (BPUserModel *)[cache objectForKey:lastUser];
        BPUserModel *model = [BPUserModel shareModel];
        model.userName = userModel.userName;
        model.password = userModel.password;
        model.changeUserName = userModel.changeUserName;
        model.isLogin = userModel.isLogin;
        
    }else{
       userModel = [BPUserModel shareModel];
    }
    
    NSString *userName = userModel.userName;
    userName = [userName stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    NSString *newUserName = userModel.changeUserName;
    if(newUserName && newUserName.length != 0)
    {
        userName = newUserName;
    }
    NSString *title = userModel.isLogin? userName :@"登录/注册";
    [_loginBtn setTitle:title forState:UIControlStateNormal];
}

-(void)setupTableView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    [self.tableView registerClass:[BPPersonalTableViewCell class] forCellReuseIdentifier:@"personalCell"];
    UIView *headerView = [UIView new];
    headerView.frame = CGRectMake(0, 0, SCREENWIDTH, 100);
    
    UIImageView *accountImage = [UIImageView new];
    [headerView addSubview:accountImage];
    [accountImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerY.mas_equalTo(headerView);
        make.left.mas_equalTo(25);
    }];
    [accountImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认头像"]];
    
    UIButton *loginBtn = [UIButton new];
    [headerView addSubview: loginBtn];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(headerView);
        make.height.mas_equalTo(60);
        make.left.mas_equalTo(accountImage.mas_right).mas_offset(10);
        make.right.mas_equalTo(-15);
    }];
    _loginBtn = loginBtn;
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    loginBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    loginBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [loginBtn addTarget:self action:@selector(didClickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [UIView new];
    [headerView addSubview:lineView];
    lineView.alpha = 0.6;
    lineView.backgroundColor = [UIColor grayColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.right.left.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
    }];
    self.tableView.tableHeaderView = headerView;
    self.tableView.tableFooterView = [UIView new];

}

-(void)didClickLoginBtn:(UIButton *)sender
{
    if([BPUserModel shareModel].isLogin)
    {
        return;
    }
    
    [self.navigationController pushViewController :[BPLoginViewController new] animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            NSLog(@"充值");
            [MBProgressHUD showSuccess:@"敬请期待"];
            break;
        case 1:
            NSLog(@"关注");
            [MBProgressHUD showSuccess:@"敬请期待"];
            break;
        case 2:
            NSLog(@"设置");
            [self pushToSettingVC];
            break;
        case 3:
            NSLog(@"邀请码");
            [MBProgressHUD showSuccess:@"敬请期待"];
            break;
            
        default:
            break;
    }
}

-(void)pushToSettingVC
{
    BPSettingViewController *settingVC = [BPSettingViewController new];
    settingVC.accountName = _loginBtn.titleLabel.text;
    [self.navigationController pushViewController:settingVC animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPPersonalTableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"personalCell" forIndexPath:indexPath];
    cell.icon.image = [UIImage imageNamed:self.titleArr[indexPath.row]];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}

-(NSMutableArray *)titleArr
{
    if(_titleArr == nil)
    {
        _titleArr = [NSMutableArray arrayWithArray:@[@"充值",@"我的关注",@"设置",@"邀请码"]];
    }
    return _titleArr;
}

@end
