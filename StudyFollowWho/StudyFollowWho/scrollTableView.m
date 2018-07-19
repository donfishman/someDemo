//
//  scrollTableView.m
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/7/2.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "scrollTableView.h"
#import "DateModel.h"

@interface scrollTableView ()
//@property(nonatomic,strong)

//@property (nonatomic,assign)BOOL isDraging;

@end

static BOOL _isDraging = NO;
@implementation scrollTableView


-(NSMutableArray *)DateArray
{
    if (!_DateArray) {
        _DateArray = [NSMutableArray array];
    }
    return _DateArray;
}

-(id)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)addTableView
{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor lightTextColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    [self addSubview:self.tableView];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
        DateModel *model = self.DateArray[section];
        label.text = [NSString stringWithFormat:@"%@",model.Date];
        
        return label;
   
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifier = @"cellID";
    UITableViewCell *cell = nil;
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = @"123";
    }
    
    return cell;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   // NSIndexPath *indexPath = [[self.tableView indexPathsForVisibleRows] firstObject];
    
    NSArray *array = [self.tableView indexPathsForVisibleRows];
    
    NSLog(@"TableArray.count===%ld",array.count);
    
    NSInteger num = 7 - array.count;
    
    static DateModel *model;
    
    if (num == 7) {
        model = self.DateArray[6];

    }else{
        model = self.DateArray[num];

    }
    
    
    NSString *identifier = model.weekDay;
    
    if ([self.delegete respondsToSelector:@selector(changePointViewPositionWithStr:)]&&_isDraging == YES) {
        [self.delegete changePointViewPositionWithStr:identifier];
    }
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isDraging = YES;
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    _isDraging = NO;
}
-(void)scrollToRowWithRow:(NSInteger)Row
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:Row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}


@end
