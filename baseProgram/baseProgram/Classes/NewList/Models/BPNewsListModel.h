//
//  BPNewsListModel.h
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPNewsListTipsModel.h"

@interface BPNewsListModel : NSObject

@property (nonatomic, strong) NSString * awayId;
@property (nonatomic, strong) NSString * awayLogo;
@property (nonatomic, strong) NSString * awayName;
@property (nonatomic, strong) NSString * homeId;
@property (nonatomic, strong) NSString * homeLogo;
@property (nonatomic, strong) NSString * homeName;
@property (nonatomic, strong) NSString * leagueColor;
@property (nonatomic, strong) NSString * leagueName;
@property (nonatomic, strong) NSString * matchBeginTime;
@property (nonatomic, strong) NSString * matchId;
@property (nonatomic, strong) NSString * matchNo;
@property (nonatomic, strong) NSString * saleEndTime;
@property (nonatomic, strong) NSString * saleStatus;
@property (nonatomic, strong) NSMutableArray<BPNewsListTipsModel *>* tips;

@property (nonatomic, assign)BOOL isShowMore;
@property (nonatomic, assign)CGFloat rowHeight;


@end
