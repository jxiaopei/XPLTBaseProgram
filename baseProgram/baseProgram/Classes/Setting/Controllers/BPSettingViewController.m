//
//  BPSettingViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/25.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPSettingViewController.h"
#import "BPChangeUserNameViewController.h"
#import "BPPersonalViewController.h"

@interface BPSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArr;
@end

@implementation BPSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self setupTableView];

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
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"settingCell"];
    self.tableView.scrollEnabled = NO;
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREENWIDTH, 200);
    self.tableView.tableFooterView = footView;
    
    UIView *lineView = [UIView new];
    [footView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(footView.mas_top).mas_offset(1);
        make.left.right.mas_equalTo(footView);
        make.height.mas_equalTo(0.5);
    }];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.6;
    
    
    UIButton *logOutBtn = [UIButton new];
    [footView addSubview:logOutBtn];
    [logOutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(footView);
        make.width.mas_equalTo(SCREENWIDTH - 30);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(40);
    }];
    logOutBtn.layer.masksToBounds = YES;
    logOutBtn.layer.cornerRadius = 10;
    [logOutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    logOutBtn.backgroundColor = GlobalGreenColor;
    logOutBtn.titleLabel.textColor = [UIColor whiteColor];
    logOutBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [logOutBtn addTarget:self action:@selector(didClickLogOutBtn:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)didClickLogOutBtn:(UIButton *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BPUserModel *model = [BPUserModel shareModel];
        model.isLogin = NO;
        [[NSUserDefaults standardUserDefaults]setObject:model forKey:model.userName];
        for(UIViewController *vc in self.navigationController.viewControllers)
        {
            
            if([vc isKindOfClass:[BPPersonalViewController class]])
            {
                BPPersonalViewController *personalVC = (BPPersonalViewController *)vc;
                [self.navigationController popToViewController:personalVC animated:YES];
            }
            
        }
        
    }];
    
    [alert addAction:cancelAction];
    [alert addAction:logoutAction];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    if(indexPath.row != 1)
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        NSString *verson =  [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        UILabel *versonLabel = [UILabel new];
        [cell.contentView addSubview:versonLabel];
        versonLabel.text = verson;
        versonLabel.font = [UIFont systemFontOfSize:14];
        versonLabel.textColor = [UIColor blackColor];
        [versonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(cell.contentView);
            make.right.mas_equalTo(-15);
        }];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            [self pushToChangeUserNameVC];
            break;
        case 1:
            break;
            
        default:
            break;
    }
}

-(void)pushToChangeUserNameVC
{
    BPUserModel *model = [BPUserModel shareModel];
    if(!model.isLogin)
    {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    BPChangeUserNameViewController *changeUserNameVC = [BPChangeUserNameViewController new];
    changeUserNameVC.accountName = _accountName;
    [self.navigationController pushViewController:changeUserNameVC animated:YES];
}

-(NSMutableArray *)titleArr
{
    if(_titleArr == nil)
    {
        _titleArr = [NSMutableArray arrayWithArray:@[@"修改昵称",@"当前版本"]];
    }
    return _titleArr;
}

@end
