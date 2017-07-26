//
//  BPNewsListTipsModel.m
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsListTipsModel.h"

@implementation BPNewsListTipsModel

-(CGFloat)rowHeight
{
    if(_picUrl.length == 0)
    {
        _rowHeight = 230 ;
    }else{
        _rowHeight = 330 ;
    }
    return _rowHeight;
}

@end
