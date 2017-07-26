//
//  BPNewsTitleModel.h
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPRouteTarget.h"

@interface BPNewsTitleModel : NSObject

@property (nonatomic, strong) NSString * dateline;
@property (nonatomic, strong) NSString * imageUrl;
@property (nonatomic, strong) BPRouteTarget * routeTarget;
@property (nonatomic, strong) NSString * title;

@end
