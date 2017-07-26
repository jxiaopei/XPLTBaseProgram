//
//  BPLoginViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/24.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLoginViewController.h"
#import "BPResignViewController.h"

@interface BPLoginViewController ()


@property(nonatomic, strong)UITextField *passwordText;


@end

@implementation BPLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"登录";
    UIButton *resignBtn = [UIButton new];
    resignBtn.frame = CGRectMake(0, 0, 40, 30);
    [resignBtn setTitle:@"注册" forState:UIControlStateNormal];
    resignBtn.titleLabel.textColor = [UIColor whiteColor];
    resignBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [resignBtn addTarget:self action:@selector(didClickResignBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtnItem = [[UIBarButtonItem alloc]initWithCustomView:resignBtn];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    
    [self setupUI];
    
}

-(void)setupUI
{
    UIButton *loginBtn = [UIButton new];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 10;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.backgroundColor = GlobalGreenColor;
    loginBtn.titleLabel.textColor = [UIColor whiteColor];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginBtn addTarget:self action:@selector(didClickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *secureBTn = [UIButton new];
    [self.view addSubview:secureBTn];
    [secureBTn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [secureBTn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    [secureBTn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(loginBtn.mas_top).mas_offset(-50);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
        make.right.mas_equalTo(loginBtn);
    }];
    [secureBTn addTarget:self action:@selector(didClickSecureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *passwordText = [UITextField new];
    [self.view addSubview:passwordText];
    _passwordText = passwordText;
    [passwordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(secureBTn.mas_left).mas_offset(-5);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(secureBTn);
    }];
    passwordText.font = [UIFont systemFontOfSize:14];
    passwordText.borderStyle = UITextBorderStyleNone;
    passwordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordText.placeholder = @"请输入您的密码";
    passwordText.secureTextEntry = YES;
    
    UIView *lineView = [UIView new];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(passwordText.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(passwordText);
        make.height.mas_equalTo(0.5);
    }];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.6;
    
    UITextField *phoneText = [UITextField new];
    [self.view addSubview:phoneText];
    _phoneText = phoneText;
    [phoneText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(passwordText.mas_top).mas_offset(-20);
    }];
    phoneText.font = [UIFont systemFontOfSize:14];
    phoneText.borderStyle = UITextBorderStyleNone;
    phoneText.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneText.placeholder = @"请输入您的手机号码";
    phoneText.keyboardType = UIKeyboardTypeNumberPad;
    UIView *lineView1 = [UIView new];
    [self.view addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(phoneText.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(phoneText);
        make.height.mas_equalTo(0.5);
    }];
    lineView1.backgroundColor = [UIColor grayColor];
    lineView1.alpha = 0.6;
}

-(void)didClickResignBtn:(UIButton *)sender
{
    _passwordText.text = nil;
    _phoneText.text = nil;
    [self.navigationController pushViewController:[BPResignViewController new] animated:YES];
}

-(void)didClickSecureBtn:(UIButton *)sender
{
    sender.selected = !sender.selected;
    _passwordText.secureTextEntry = !_passwordText.secureTextEntry;
}

-(void)didClickLoginBtn:(UIButton *)sender
{
    if(_phoneText.text.length == 0)
    {
        [XCTools shakeAnimationForView:_phoneText];
        [MBProgressHUD showError:@"请输入您的手机号码"];
        
        return;
    }
    
    if (_passwordText.text.length > 20) {
        [XCTools shakeAnimationForView:_passwordText];
        [MBProgressHUD showError:@"请输入小于20位的密码"];
        
        return;
    }
    
    if (![CheckHelper checkTelNumber:_phoneText.text]) {
        
        [XCTools shakeAnimationForView:_phoneText];
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        
        return;
    }
    
    YYCache *cache = [YYCache cacheWithName:CacheKey];
    if(! [cache containsObjectForKey:_phoneText.text])
    {
        [MBProgressHUD showError:@"此账号不存在,请注册后再登录"];
        return;
    }
    
    BPUserModel *model = (BPUserModel *)[cache objectForKey:_phoneText.text];
//    [MBProgressHUD showMessage:@"正在登录"];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//         [MBProgressHUD hideHUD];
         
         if(![model.password isEqualToString:_passwordText.text])
         {
             [MBProgressHUD showError:@"密码错误,请重新输入"];
             _passwordText.text = nil;
             return;
         }
         
         AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
         [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
             
             if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
             {
                 [MBProgressHUD showSuccess:@"登录成功"];
                 model.isLogin = YES;
                 BPUserModel *model1 = [BPUserModel shareModel];
                 model1.isLogin = YES;
                 model1.userName = _phoneText.text;
                 model1.password = _passwordText.text;
                 model.userName = _phoneText.text;
                 model.password = _passwordText.text;
                 [cache setObject:model forKey:_phoneText.text];
                 [[NSUserDefaults standardUserDefaults] setObject:_phoneText.text forKey:@"lastUser"];
                 [self.navigationController popViewControllerAnimated:YES];
                 
             }else{
                 [MBProgressHUD showError:@"网络错误"];
             }
             
         }];
         [manager startMonitoring];
     });

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneText endEditing:YES];
    [_passwordText endEditing:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUD];
}

@end
