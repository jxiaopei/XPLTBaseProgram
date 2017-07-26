//
//  BPNewsListCell.h
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPNewsListModel.h"

@interface BPNewsListCell : UITableViewCell

@property(nonatomic,strong)BPNewsListModel *dataModel;
@property(nonatomic,copy) void(^refreshBlock)();
@property(nonatomic,copy) void(^pushVCBlock)();

@end
