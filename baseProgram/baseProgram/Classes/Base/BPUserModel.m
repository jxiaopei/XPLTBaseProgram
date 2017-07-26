//
//  BPUserModel.m
//  baseProgram
//
//  Created by iMac on 2017/7/25.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPUserModel.h"

@implementation BPUserModel

+(BPUserModel *)shareModel
{
    static BPUserModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [self new];
    });
    return model;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
   
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.changeUserName forKey:@"changeUserName"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self.userName  = [aDecoder decodeObjectForKey:@"userName"];
    self.password = [aDecoder decodeObjectForKey:@"password"];
    self.changeUserName = [aDecoder decodeObjectForKey:@"changeUserName"];
    self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
    return self;
}



@end
