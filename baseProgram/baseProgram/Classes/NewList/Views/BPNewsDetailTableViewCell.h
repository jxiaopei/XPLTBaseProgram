//
//  BPNewsDetailTableViewCell.h
//  baseProgram
//
//  Created by iMac on 2017/7/23.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPNewsListTipsModel.h"
//#import "BPNewsDetailTitleModel.h"
#import "BPNewsListModel.h"

@interface BPNewsDetailTableViewCell : UITableViewCell

@property(nonatomic,strong)BPNewsListTipsModel *tipsModel;
//@property(nonatomic,strong)BPNewsDetailTitleModel *titleModel;
@property(nonatomic,strong)BPNewsListModel *dataModel;;

@end
