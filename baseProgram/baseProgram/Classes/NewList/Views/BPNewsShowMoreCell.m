//
//  BPNewsShowMoreCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewsShowMoreCell.h"

@implementation BPNewsShowMoreCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *lineView = [UIView new];
        lineView.alpha = 0.6;
        [self addSubview:lineView];
        lineView.backgroundColor = [UIColor grayColor];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(2);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
        UILabel *moreLabel = [UILabel new];
        [self addSubview:moreLabel];
        moreLabel.text = @"查看更多";
        moreLabel.font = [UIFont systemFontOfSize:14];
        moreLabel.textColor = [UIColor orangeColor];
        [moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(15);
        }];
        
        UIImageView *moreImage = [UIImageView new];
        [self addSubview:moreImage];
        [moreImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 15));
            make.right.mas_equalTo(-20);
            make.top.mas_equalTo(10);
        }];
        moreImage.image = [UIImage imageNamed:@"下箭头"];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    

    
}



@end
