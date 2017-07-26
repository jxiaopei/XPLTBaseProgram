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
#import "BPSettingTableViewCell.h"
#import<AssetsLibrary/AssetsLibrary.h>

@interface BPSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>

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
    [self.tableView registerClass:[BPSettingTableViewCell class] forCellReuseIdentifier:@"headerSettingCell"];
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
    BPUserModel *model = [BPUserModel shareModel];
    if(!model.isLogin)
    {
        return;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要退出登录吗?" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *logoutAction = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        BPUserModel *model = [BPUserModel shareModel];
        model.isLogin = NO;
        YYCache *cache = [YYCache cacheWithName:CacheKey];
        [cache setObject:model forKey:model.userName];
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
    if(indexPath.row == 0)
    {
        BPSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerSettingCell" forIndexPath:indexPath];
        [cell.icon sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"默认头像"]];
        cell.titleLabel.text = self.titleArr[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingCell" forIndexPath:indexPath];
        
        cell.textLabel.text = self.titleArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row != 2)
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
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return 60;
    }else{
        return 46;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            [MBProgressHUD showSuccess:@"敬请期待"];
            //[self didTapToChangeHeaderImageViewAction];
            break;
        case 1:
            [self pushToChangeUserNameVC];
            break;
        case 2:
            break;
            
        default:
            break;
    }
}

-(void)didTapToChangeHeaderImageViewAction
{
    
    BPUserModel *model = [BPUserModel shareModel];
    if(!model.isLogin)
    {
        [MBProgressHUD showError:@"请先登录"];
        return;
    }
    //设置提示文字内容
    NSString *string1;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        string1 = @"iPhone";
    } else {
        string1 = @"iPad";
    }
    
    UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    //相机
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        //判断是否支持相机
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            
            NSString *mediaType = AVMediaTypeVideo;
            AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
            if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
                //无相机权限 则弹出提示
                NSString *tips = [NSString stringWithFormat:@"请在%@的”设置-隐私-相机“选项中，允许App访问你的手机相机",string1];
                
                UIAlertController *cameraAlert = [UIAlertController alertControllerWithTitle:@"提示" message:tips preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                
                [cameraAlert addAction:confirmAction];
                
                [self presentViewController:cameraAlert animated:YES completion:nil];
            }else{
                //有权限 弹出照相机
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = (id)self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }
        }
        
    }];
    
    //相册
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if(author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
            
            //没有相册权限
            NSString *tips = [NSString stringWithFormat:@"请在%@的”设置-隐私-照片“选项中，允许App访问你的手机相册",string1];
            
            UIAlertController *albumAlert = [UIAlertController alertControllerWithTitle:@"提示" message:tips preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            
            [albumAlert addAction:confirmAction];
            
            [self presentViewController:albumAlert animated:YES completion:nil];
        }else{
            //有权限 弹出相册选择图片
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = (id)self;
            imagePickerController.allowsEditing = YES;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:  UIAlertActionStyleCancel handler:nil];
    
    [alertViewController addAction:cameraAction];
    [alertViewController addAction:albumAction];
    [alertViewController addAction:cancelAction];
    [self presentViewController:alertViewController animated:YES completion:nil];
}

#pragma mark - 相册代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];

    NSString *path_sandox = NSHomeDirectory();
    //设置一个图片的存储路径
    NSString *imagePath = [path_sandox stringByAppendingString:@"/Documents/upload.png"];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
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
        _titleArr = [NSMutableArray arrayWithArray:@[@"修改头像",@"修改昵称",@"当前版本"]];
    }
    return _titleArr;
}

@end
