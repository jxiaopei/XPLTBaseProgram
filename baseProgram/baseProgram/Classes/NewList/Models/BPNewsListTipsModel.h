//
//  BPNewsListTipsModel.h
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPNewsListTipsModel : NSObject

@property (nonatomic, strong) NSString * authorId;
@property (nonatomic, strong) NSString * authorName;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * picUrl;
@property (nonatomic, strong) NSString * publishTime;
@property (nonatomic, strong) NSString * subTitle;
@property (nonatomic, strong) NSString * teamTypeId;
@property (nonatomic, strong) NSString * teamTypeName;
@property (nonatomic, strong) NSString * tipsTypeId;
@property (nonatomic, strong) NSString * tipsTypeName;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * withPic;

@property (nonatomic, assign) CGFloat rowHeight;

@end
