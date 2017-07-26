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

@end
