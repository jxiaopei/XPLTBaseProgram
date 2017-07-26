//
//  BPMainViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/20.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPMainViewController.h"
#import "BPNewListViewController.h"
#import "BPBaseTabBarController.h"

@interface BPMainViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,assign)BOOL isVertical;
@property(nonatomic,strong)NSMutableArray *urlArr;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UIButton *selectedBtn;
@property(nonatomic,strong)UIView *tabBar;
@property(nonatomic,strong)UILabel *selectLabel;

@end

@implementation BPMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBar];
    [self setupWebView];
    [self getStatus];
    self.index = 0;
   
}

-(void)setupWebView
{
    self.webView = [UIWebView new];
    UIScrollView *scrollView = (UIScrollView *)self.webView.subviews[0];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:self.webView];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
}

-(void)setupTabBar
{
    UIView *tabBar = [UIView new];
    tabBar.hidden = YES;
    tabBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tabBar];
    [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.alpha = 0.6;
    [tabBar addSubview:lineView];
    self.tabBar = tabBar;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    
    NSArray *tabBarImageArr = @[@"home",@"back",@"goto",@"refresh",@"exit"];
    NSArray *tabBarTitleArr = @[@"首页",@"返回",@"前进",@"刷新",@"退出"];
    
    for(int i = 0;i < 5;i++)
    {
        UIView *btnView = [UIView new];
        btnView.frame = CGRectMake(i * SCREENWIDTH /5, 0, SCREENWIDTH/5, 49);
        btnView.userInteractionEnabled = YES;
        UIImageView *btnImageView = [UIImageView new];
        btnImageView.image = [UIImage imageNamed:tabBarImageArr[i]];
        [btnView addSubview:btnImageView];
        [btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.left.mas_equalTo(SCREENWIDTH/10-12.5);
            make.top.mas_equalTo(5);
        }];
        btnImageView.userInteractionEnabled = YES;
        UILabel *btnTitle = [UILabel new];
        [btnView addSubview:btnTitle];
        [btnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(btnImageView.mas_bottom).mas_offset(3);
        }];
        btnTitle.text = tabBarTitleArr[i];
        btnTitle.font = [UIFont systemFontOfSize:10];
        btnTitle.textColor = [UIColor lightGrayColor];
        btnTitle.textAlignment = NSTextAlignmentCenter;
        btnTitle.userInteractionEnabled = YES;
        btnView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickTabBarBtn:)];
        [btnView addGestureRecognizer:tap];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickLabelOrImageView:)];
        [btnTitle addGestureRecognizer:tapGesture];
        [btnImageView addGestureRecognizer:tapGesture];
        
        [tabBar addSubview:btnView];
        
        if(i == 0)
        {
            btnTitle.textColor = [UIColor blueColor];
            self.selectLabel = btnTitle;
        }
    }
    
}

-(void)didClickLabelOrImageView:(UITapGestureRecognizer *)tap
{
    [self didClickTabBarBtn:tap];
}

-(void)didClickTabBarBtn:(UITapGestureRecognizer *)tap
{
    for (int i= 0; i< tap.view.subviews.count;i++)
    {
        if([tap.view.subviews[i] isKindOfClass:[UILabel class]])
        {
            UILabel *title = tap.view.subviews[i];
            title.textColor = [UIColor blueColor];
            self.selectLabel.textColor = [UIColor lightGrayColor];
            self.selectLabel = title;
        }
    }

//    [self animationWithIndex:tap.view.tag];
    
    switch (tap.view.tag) {
        case 0:
            break;
        case 1:
            [self goBack];
            break;
        case 2:
            [self goForward];
            break;
        case 3:
            [self refresh];
            break;
        case 4:
            [self exitApp];
            break;
        default:
            break;
    }
    
}

-(void)goBack
{
    if(self.webView.canGoBack)
    {
        [self.webView goBack];
    }
}

-(void)goForward
{
    if(self.webView.canGoForward)
    {
        [self.webView goForward];
    }
}

-(void)refresh
{
    [self.webView reload];
}

//退出动画
-(void)exitApp{
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:[UIApplication sharedApplication].keyWindow cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    [UIApplication sharedApplication].keyWindow.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
}

- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID isEqualToString:@"exitApplication"]) {
        
        exit(0);
        
    }
    
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UIView")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.08;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer]
     addAnimation:pulse forKey:nil];
    
}

-(void)loadRequestWithUrlIndex:(NSInteger)index
{
    NSArray *cookies =[[NSUserDefaults standardUserDefaults] objectForKey:@"cookies"];
    if (cookies.count >0) {
        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
        [cookieProperties setObject:[cookies objectAtIndex:0] forKey:NSHTTPCookieName];
        [cookieProperties setObject:[cookies objectAtIndex:1] forKey:NSHTTPCookieValue];
        [cookieProperties setObject:[cookies objectAtIndex:3] forKey:NSHTTPCookieDomain];
        [cookieProperties setObject:[cookies objectAtIndex:4] forKey:NSHTTPCookiePath];
        NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:cookieProperties];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookieuser];
    }
    if(_urlArr.count)
    {
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.urlArr[self.index]]];
        
        [self.webView loadRequest:request];
    }
}

-(void)getStatus
{
    [[BPNetRequest getInstance]postJsonWithUrl:COMPANYURL parameters:COMPANYPARA success:^(id responseObject) {
        
        if([responseObject[@"status"] integerValue] == 200)
        {
            if([responseObject[@"data"][@"switch"] integerValue] == 1)
            {
                NSString *urls = responseObject[@"data"][@"url"];
                _urlArr = [[urls componentsSeparatedByString:@","] copy];
                [self loadRequestWithUrlIndex:self.index];
            }else if([responseObject[@"data"][@"switch"] integerValue] == 0)
            {
                BPBaseTabBarController *tabBarVC = [BPBaseTabBarController new];
                [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
            }
        }
        
//        NSLog(@"%@",[responseObject mj_JSONString]);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    UIDeviceOrientation deviceOrientation = (UIDeviceOrientation)[UIApplication sharedApplication].statusBarOrientation ;
    //判断横竖屏
    if(deviceOrientation == UIDeviceOrientationPortrait|| deviceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        //竖屏
        self.tabBar.hidden = NO;
        self.tabBar.frame = CGRectMake(0, SCREENHEIGHT -49, SCREENWIDTH, 49);
        self.webView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-49);

    }else{
        //横屏
        self.tabBar.hidden = YES;
        self.tabBar.frame = CGRectMake(0, -49, SCREENWIDTH, 49);
        self.webView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    }
    
    
}

//webView代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
//     [SVProgressHUD showWithStatus:@"开始加载"];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
//    [SVProgressHUD showErrorWithStatus:@"加载失败"];
    self.index++;
    
    if(_index < self.urlArr.count - 1)
    {
        NSURL *url = [NSURL URLWithString:self.urlArr[_index]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        [self.webView loadRequest:request];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//    [SVProgressHUD showSuccessWithStatus:@"加载成功"];
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSHTTPCookie *cookie = nil;
    for(id c in cookies)
    {
        if([c isKindOfClass:[NSHTTPCookie class]])
        {
            cookie = (NSHTTPCookie *)c;
            if ([cookie.name isEqualToString:@"PHPSESSID"]) {
                NSNumber *sessionOnly =[NSNumber numberWithBool:cookie.sessionOnly];
                NSNumber *isSecure = [NSNumber numberWithBool:cookie.isSecure];
                NSArray *cookies = [NSArray arrayWithObjects:cookie.name, cookie.value, sessionOnly, cookie.domain, cookie.path, isSecure, nil];
                [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"cookies"];
                NSLog(@"%@: %@", cookie.name, cookie.value);
                break;
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//懒加载
-(NSMutableArray *)urlArr
{
    if(_urlArr == nil)
    {
        _urlArr = [NSMutableArray array];
    }
    return _urlArr;
}




@end
