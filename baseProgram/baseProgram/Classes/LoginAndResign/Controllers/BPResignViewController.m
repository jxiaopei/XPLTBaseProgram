//
//  BPResignViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/25.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPResignViewController.h"
#import "BPLoginViewController.h"
@interface BPResignViewController ()
@property(nonatomic, strong)UITextField *phoneText;
@property(nonatomic, strong)UITextField *passwordText;
@property(nonatomic, strong)UITextField *secPasswordText;
@end

@implementation BPResignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self setupUI];
    
}

-(void)setupUI
{
    UIButton *resignBtn = [UIButton new];
    [self.view addSubview:resignBtn];
    [resignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view).mas_offset(40);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
    resignBtn.layer.masksToBounds = YES;
    resignBtn.layer.cornerRadius = 10;
    [resignBtn setTitle:@"注册" forState:UIControlStateNormal];
    resignBtn.backgroundColor = GlobalGreenColor;
    resignBtn.titleLabel.textColor = [UIColor whiteColor];
    resignBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [resignBtn addTarget:self action:@selector(didClickResignBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *secureBTn1 = [UIButton new];
    secureBTn1.tag = 200;
    [self.view addSubview:secureBTn1];
    [secureBTn1 setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [secureBTn1 setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    [secureBTn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(resignBtn.mas_top).mas_offset(-50);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
        make.right.mas_equalTo(resignBtn);
    }];
    [secureBTn1 addTarget:self action:@selector(didClickSecureBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *secPasswordText = [UITextField new];
    [self.view addSubview:secPasswordText];
    _secPasswordText = secPasswordText;
    [secPasswordText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(secureBTn1.mas_left).mas_offset(-5);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(secureBTn1);
    }];
    secPasswordText.font = [UIFont systemFontOfSize:14];
    secPasswordText.borderStyle = UITextBorderStyleNone;
    secPasswordText.clearButtonMode = UITextFieldViewModeWhileEditing;
    secPasswordText.placeholder = @"请再次输入您的密码";
    secPasswordText.secureTextEntry = YES;
    
    UIView *lineView2 = [UIView new];
    [self.view addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(secPasswordText.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(secPasswordText);
        make.height.mas_equalTo(0.5);
    }];
    lineView2.backgroundColor = [UIColor grayColor];
    lineView2.alpha = 0.6;
    
    UIButton *secureBTn = [UIButton new];
    secureBTn.tag = 100;
    [self.view addSubview:secureBTn];
    [secureBTn setImage:[UIImage imageNamed:@"隐藏密码"] forState:UIControlStateNormal];
    [secureBTn setImage:[UIImage imageNamed:@"显示密码"] forState:UIControlStateSelected];
    [secureBTn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(secPasswordText.mas_top).mas_offset(-20);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(30);
        make.right.mas_equalTo(resignBtn);
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

-(void)didClickSecureBtn:(UIButton *)sender
{
    if(sender.tag == 100)
    {
       _passwordText.secureTextEntry = !_passwordText.secureTextEntry;
    }else{
        _secPasswordText.secureTextEntry = !_secPasswordText.secureTextEntry;
    }
    sender.selected = !sender.selected;
}


-(void)didClickResignBtn:(UIButton *)sender
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
    
    if (_secPasswordText.text.length > 20) {
        [XCTools shakeAnimationForView:_secPasswordText];
        [MBProgressHUD showError:@"请输入小于20位的密码"];
        
        return;
    }
    
    if(![_secPasswordText.text isEqualToString:_passwordText.text])
    {
        [XCTools shakeAnimationForView:_passwordText];
        [XCTools shakeAnimationForView:_secPasswordText];
        [MBProgressHUD showError:@"两次输入的密码不一致"];
        
        return;
    }
    
    if (![CheckHelper checkTelNumber:_phoneText.text]) {
        
        [XCTools shakeAnimationForView:_phoneText];
        [MBProgressHUD showError:@"请输入正确的手机号码"];
        
        return;
    }
    BPUserModel *model = [[NSUserDefaults standardUserDefaults]objectForKey:_phoneText.text];
    if(model.userName && model.userName.length != 0)
    {
        [MBProgressHUD showError:@"此账号已存在,请直接登录"];
        [self popToLoginViewController];
        return;
    }
    
    [MBProgressHUD showMessage:@"正在注册"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
        [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            if(status == AFNetworkReachabilityStatusReachableViaWiFi || status == AFNetworkReachabilityStatusReachableViaWWAN)
            {
                [MBProgressHUD showSuccess:@"注册成功"];
               BPUserModel *model =  [BPUserModel shareModel];
                model.userName = _phoneText.text;
                model.password = _passwordText.text;
                [[NSUserDefaults standardUserDefaults]setObject:model forKey:_phoneText.text];

                [self popToLoginViewController];
            }else{
               [MBProgressHUD showError:@"网络错误"];
            }
            
        }];
        [manager startMonitoring];
    });

    
}

-(void)popToLoginViewController
{
    for(UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[BPLoginViewController class]])
        {
            BPLoginViewController *loginVC = (BPLoginViewController *)vc;
            loginVC.phoneText.text = _phoneText.text;
            [self.navigationController popToViewController:loginVC animated:YES];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_phoneText endEditing:YES];
    [_passwordText endEditing:YES];
    [_secPasswordText endEditing:YES];
}

@end
