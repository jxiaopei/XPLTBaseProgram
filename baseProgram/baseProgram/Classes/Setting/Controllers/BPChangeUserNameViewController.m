//
//  BPChangeUserNameViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/25.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPChangeUserNameViewController.h"

@interface BPChangeUserNameViewController ()

@property(nonatomic,strong)UITextField *accountNameText;

@end

@implementation BPChangeUserNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    [self setupUI];
    
}


-(void)setupUI
{
    UIButton *confrimBtn = [UIButton new];
    [self.view addSubview:confrimBtn];
    [confrimBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(-40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    confrimBtn.layer.masksToBounds = YES;
    confrimBtn.layer.cornerRadius = 10;
    [confrimBtn setTitle:@"确认修改" forState:UIControlStateNormal];
    confrimBtn.backgroundColor = GlobalGreenColor;
    confrimBtn.titleLabel.textColor = [UIColor whiteColor];
    confrimBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [confrimBtn addTarget:self action:@selector(didClickConfrimBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *accountNameText = [UITextField new];
    [self.view addSubview:accountNameText];
    _accountNameText = accountNameText;
    [accountNameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(confrimBtn.mas_top).mas_offset(-50);
    }];
    accountNameText.font = [UIFont systemFontOfSize:14];
    accountNameText.borderStyle = UITextBorderStyleNone;
    accountNameText.clearButtonMode = UITextFieldViewModeWhileEditing;
    accountNameText.placeholder = _accountName;
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountNameText.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(accountNameText);
        make.height.mas_equalTo(0.5);
    }];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.6;
    
}

-(void)didClickConfrimBtn:(UIButton *)sender
{
    if(_accountNameText.text.length == 0)
    {
        [XCTools shakeAnimationForView:_accountNameText];
        [MBProgressHUD showError:@"请输入您的新用户名"];
        
        return;
    }
    
    if([_accountNameText.text isEqualToString:_accountName])
    {
        [XCTools shakeAnimationForView:_accountNameText];
        [MBProgressHUD showError:@"新用户名与旧用户名重复"];
        return;
    }
    
//    [MBProgressHUD showMessage:@"正在修改"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [MBProgressHUD hideHUD];
        
        
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
            {
                YYCache *cache = [YYCache cacheWithName:CacheKey];
                [MBProgressHUD showSuccess:@"修改成功"];
                BPUserModel *model = [BPUserModel shareModel];
                model.changeUserName = _accountNameText.text;
                [cache setObject:model forKey:model.userName];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [MBProgressHUD showError:@"网络错误"];
            }
            
        }];
        [manager startMonitoring];
    });
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUD];
}

@end
