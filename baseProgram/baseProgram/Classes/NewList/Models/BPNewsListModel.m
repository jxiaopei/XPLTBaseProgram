//
//  BPNewsListModel.m
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsListModel.h"


@implementation BPNewsListModel

-(CGFloat)rowHeight
{
    if(_isShowMore)
    {
        _rowHeight = 180 + (_tips.count -1)*70;
    }else{
        _rowHeight = 200 + 85;
    }
    return _rowHeight;
}

@end
