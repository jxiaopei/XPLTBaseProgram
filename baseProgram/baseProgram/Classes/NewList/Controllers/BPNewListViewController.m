//
//  BPBaseViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/21.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPNewListViewController.h"
#import "BPNewsListCell.h"
#import "BPNewsListModel.h"
#import "BPNewsDetailViewController.h"

@interface BPNewListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *days;
@property(nonatomic,strong)UIButton *selectedBtn;


@end

@implementation BPNewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"爆料";
     [self setupTableView];
    [self getDateOfWeek];
    
   
    
}

-(void)getDateOfWeek
{
    NSDate*date = [NSDate date];
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    comps =[calendar components:NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitDay fromDate:date];//kCFCalendarUnitWeekOfYear  | NSCalendarUnitWeekday |
    
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekday = [comps weekday];
    
    NSInteger daysBefore = weekday - 1;
    NSInteger daysAfter = 7 - weekday;
    NSMutableArray *days = [NSMutableArray array];
    if(daysBefore)
    {
        for(int i = (int)daysBefore;i >0 ;i--)
        {
            NSDate *beforeday = [NSDate dateWithTimeIntervalSinceNow:(- 24 * 60 * 60 * i)];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd"];
            NSString *beforedayStr = [formatter stringFromDate:beforeday];
            [days addObject:beforedayStr];
        }
    }
    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"MM-dd"];
    NSString *now = [dateFormatter stringFromDate:date];
    [days addObject:now];

    if(daysAfter)
    {
        for(int i = 1;i < daysAfter+1;i++)
        {
            NSDate *afterday = [NSDate dateWithTimeIntervalSinceNow:(24 * 60 * 60 * i)];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MM-dd"];
            NSString *afterdayStr = [formatter stringFromDate:afterday];
            [days addObject:afterdayStr];
        }
    }
    _days = days;
    
    UIView *dateSelectView = [UIView new];
    dateSelectView.frame = CGRectMake(0, 0, SCREENWIDTH, 64);
    CGFloat margain = (SCREENWIDTH - 30 - 30 * 7)/6;
    NSArray *weekDayStrArr = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    for(int i = 0;i < 7;i++)
    {
        UIButton *weekDayBtn = [UIButton new];
        [dateSelectView addSubview:weekDayBtn];
        [weekDayBtn addTarget:self action:@selector(didClickWeekDayBtn:) forControlEvents:UIControlEventTouchUpInside];
        weekDayBtn.frame = CGRectMake(15 + (30 + margain)* i, 20, 30, 30);
        UILabel *dateLabel = [UILabel new];
        [weekDayBtn addSubview: dateLabel];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(weekDayBtn);
            make.left.mas_equalTo(2);
            make.right.mas_equalTo(-2);
        }];
        weekDayBtn.tag = i;
        UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didClickDateLabel:)];
        [dateLabel addGestureRecognizer:tapAction];
        dateLabel.numberOfLines = 2;
        dateLabel.adjustsFontSizeToFitWidth = YES;
        dateLabel.text = [NSString stringWithFormat:@"%@%@",weekDayStrArr[i],days[i]];
        dateLabel.font = [UIFont systemFontOfSize:11];
        dateLabel.userInteractionEnabled = YES;
        dateLabel.textColor = [UIColor blackColor];
        if(i == weekday-1)
        {
            [self didClickWeekDayBtn:weekDayBtn];
        }
    }
    UIView *lineView = [UIView new];
    lineView.alpha = 0.6;
    [dateSelectView addSubview:lineView];
    lineView.backgroundColor = [UIColor grayColor];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    self.tableView.tableHeaderView = dateSelectView;
}

-(void)didClickDateLabel:(UIGestureRecognizer *)tapAction
{
    [self didClickWeekDayBtn:(UIButton *)tapAction.view.superview];
}

-(void)didClickWeekDayBtn:(UIButton *)sender
{
    sender.backgroundColor = GlobalGreenColor;
    self.selectedBtn.backgroundColor = [UIColor whiteColor];
    self.selectedBtn = sender;
    
    [self getDataWithIndex:sender.tag];
    
}

-(void)setupTableView
{

    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    [self.tableView registerClass:[BPNewsListCell class] forCellReuseIdentifier:@"newsListCell"];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPNewsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsListCell" forIndexPath:indexPath];
    cell.dataModel = self.dataSource[indexPath.row];
    cell.refreshBlock = ^{
        
        [self.tableView reloadData];
    };
    cell.pushVCBlock = ^{
        BPNewsDetailViewController *detailVC = [BPNewsDetailViewController new];
        detailVC.dataModel = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPNewsListModel *dataModel = self.dataSource[indexPath.row];
    return dataModel.rowHeight;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zd",indexPath.row);
    BPNewsDetailViewController *detailVC = [BPNewsDetailViewController new];
    detailVC.dataModel = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
    
}

-(void)getDataWithIndex:(NSInteger)index
{
    NSString *url = [NSString stringWithFormat:@"http://query-api.8win.com/command/execute?command=200017&matchDate=2017-%@",_days[index]];
    [[BPNetRequest getInstance]postDataWithUrl:url  parameters:nil success:^(id responseObject) {
//        NSLog(@"%@",[responseObject mj_JSONString]);
        if([responseObject[@"code"]  integerValue] == 0)
        {
           self.dataSource =  [BPNewsListModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"data"]];
            if(self.dataSource.count == 0)
            {
                [SVProgressHUD showSuccessWithStatus:@"暂无当天比赛数据"];
            }else{
              [self.tableView reloadData];
            }
        }
        
    } fail:^(NSError *error) {
         NSLog(@"%@",error.description);
    }];
    
}


-(NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
