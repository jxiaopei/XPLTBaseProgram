//
//  BPUserModel.h
//  baseProgram
//
//  Created by iMac on 2017/7/25.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPUserModel : NSObject

@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *changeUserName;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,assign)BOOL isLogin;

+(BPUserModel *)shareModel;

@end
