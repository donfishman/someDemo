//
//  ViewController.m
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/19.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "ViewController.h"
#import "CalendarOBJ.h"
#import "HeadDataView.h"
#import "scrollTableView.h"
#import "DateModel.h"

@interface ViewController ()<HeadViewDelegate,ScrollDelegete>

@property(nonatomic,strong)HeadDataView *headView;
@property(nonatomic,strong)scrollTableView *tableView;
@property(nonatomic,copy)NSMutableArray *dateArray;
@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    CalendarOBJ *calendar = [[CalendarOBJ alloc]init];
    self.dateArray = [calendar getStringOfDate];
    
    _headView = [[HeadDataView alloc]init_headViewWithFream:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.width/7)];
    _headView.delegate = self;
    _headView.dateArray = self.dateArray;
    
    [_headView creatHeadCollectionView];
    
    [self.view addSubview:_headView];
    
    _tableView = [[scrollTableView alloc]initWithFrame:CGRectMake(0, _headView.frame.origin.y+_headView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - 120)];
    _tableView.delegete = self;
    
    [_tableView.DateArray addObjectsFromArray:[_headView.dateArray subarrayWithRange:NSMakeRange(7, 7)]];

    [_tableView addTableView];
    [self.view addSubview:_tableView];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)changePointViewPositionWithStr:(NSString *)str
{
    [_headView changePointViewPositionWithStr:str];
    
}

-(void)setPointViewWithStr:(NSString *)str
{
    NSInteger row = 0;
    if ([str isEqualToString:@"Sunday"]||[str isEqualToString:@"星期天"]) {
        row = 0;
        
    }else if([str isEqualToString:@"Monday"]||[str isEqualToString:@"星期一"]){
        row = 1;
    }else if([str isEqualToString:@"Tuesday"]||[str isEqualToString:@"星期二"]){
        row = 2;
    }else if([str isEqualToString:@"Wednesday"]||[str isEqualToString:@"星期三"]){
        row = 3;

    }else if([str isEqualToString:@"Thursday"]||[str isEqualToString:@"星期四"]){
        row = 4;

    }else if([str isEqualToString:@"Friday"]||[str isEqualToString:@"星期五"]){
        row = 5;
    }else if([str isEqualToString:@"Saturday"]||[str isEqualToString:@"星期六"]){
        row = 6;

    }
    
    [_tableView scrollToRowWithRow:row];




    
}


-(void)nextMonthDate
{
    
    DateModel *dateModel = self.dateArray.lastObject;
    NSDate *date = dateModel.Date;
    
    CalendarOBJ *calendar = [[CalendarOBJ alloc]init];
    self.dateArray = [calendar getStringOfDateWithDate:date];
    _headView.dateArray = self.dateArray;
    
//    for (int i = 0; i<_headView.dateArray.count; i++) {
//        DateModel *Xmodel = _headView.dateArray[i];
//        NSLog(@"model===%@",Xmodel.Date);
//    }
    [_tableView.DateArray removeAllObjects];
    [_tableView.DateArray addObjectsFromArray:[_headView.dateArray subarrayWithRange:NSMakeRange(7, 7)]];

   
    [_headView.DataView reloadData];
    [_headView.DataView setContentOffset:CGPointMake(_headView.frame.size.width, 0)];
    [_tableView.tableView reloadData];
}

-(void)lastMonthDate
{
    DateModel *dateModel = self.dateArray.firstObject;
    NSTimeInterval time = 24*60*60;
    NSDate *date = [NSDate dateWithTimeInterval:time sinceDate:dateModel.Date];
    CalendarOBJ *calendar = [[CalendarOBJ alloc]init];
    self.dateArray = [calendar getStringOfDateWithDate:date];
    _headView.dateArray = self.dateArray;
    [_tableView.DateArray removeAllObjects];
    [_tableView.DateArray addObjectsFromArray:[_headView.dateArray subarrayWithRange:NSMakeRange(7, 7)]];

    [_headView.DataView reloadData];
    [_headView.DataView setContentOffset:CGPointMake(_headView.frame.size.width, 0)];
    [_tableView.tableView reloadData];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
