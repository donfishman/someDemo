//
//  HeadDataView.m
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/19.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "HeadDataView.h"
#import "DateCollectionViewCell.h"
#import "CalendarOBJ.h"
#import "DateModel.h"
@interface HeadDataView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>


@property(nonatomic,assign)NSInteger MonthNum;
@property(nonatomic,strong)DateModel *dateModel;
@property(nonatomic,strong)DateCollectionViewCell *SelectCell;

@end

@implementation HeadDataView

-(UIView *)PointView
{
    if (!_PointView) {
        _PointView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width/7, self.frame.size.width/7)];
        _PointView.backgroundColor = [UIColor colorWithRed:245/255.0 green:196/255.0 blue:60/255.0 alpha:1.0];
        _PointView.layer.cornerRadius = 25;
    }
    return _PointView;
}

-(NSMutableArray *)dateArray
{
    if (!_dateArray) {
        _dateArray = [NSMutableArray array];
    }
    return _dateArray;
}

-(NSInteger)MonthNum
{
    if (!_MonthNum) {
        _MonthNum = self.dateArray.count;
    }
    return _MonthNum;
}

-(id)init_headViewWithFream:(CGRect)fream
{
    if (self = [super initWithFrame:fream]) {
        
    }
    return self;
}


-(void)creatHeadCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSize = CGSizeMake(self.frame.size.width/7, self.frame.size.width/7);
    _MonthNum = self.dateArray.count;

    
    self.DataView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    [self.DataView addSubview:self.PointView];
    [self.DataView setContentOffset:CGPointMake(self.frame.size.width, 0)];
    self.DataView.backgroundColor = [UIColor redColor];
    self.DataView.pagingEnabled = YES;
    self.DataView.dataSource = self;
    self.DataView.delegate = self;
    self.DataView.showsHorizontalScrollIndicator = NO;
    
    [self.DataView registerClass:[DateCollectionViewCell class] forCellWithReuseIdentifier:@"IDCell"];
    [self addSubview:self.DataView];

    
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _SelectCell = (DateCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

    _PointView.center = _SelectCell.center;
    
    NSString *str = _SelectCell.weekLabel.text;
    
    
    if ([self.delegate respondsToSelector:@selector(setPointViewWithStr:)]) {
        [self.delegate setPointViewWithStr:str];
    }

}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"monthNum===%ld",_MonthNum);

    return _MonthNum;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DateCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"IDCell" forIndexPath:indexPath];
    DateModel *cellModel = self.dateArray[indexPath.row];
    if (cell.dateLabel||cell.weekLabel) {
        [cell.dateLabel removeFromSuperview];
        [cell.weekLabel removeFromSuperview];
    }
    [cell creatDateLabelWithDate:[NSString stringWithFormat:@"%ld月%ld",cellModel.month,cellModel.day] withWeek:cellModel.weekDay];
    
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:currentDate];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    if (cellModel.year == year && cellModel.month == month && cellModel.day == day) {
        _PointView.center = cell.center;
        
        [self.DataView sendSubviewToBack:_PointView];

    }
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.delegate = self;
    
    if (self.DataView.contentOffset.x == self.DataView.frame.size.width * (_MonthNum/7 - 1)) {
        if ([self.delegate respondsToSelector:@selector(nextMonthDate)]) {
            [self.delegate nextMonthDate];
        }
    }
    
    if (self.DataView.contentOffset.x == 0) {
        if ([self.delegate respondsToSelector:@selector(lastMonthDate)]) {
            [self.delegate lastMonthDate];
        }
    }
    
}

-(void)changePointViewPositionWithStr:(NSString *)str
{
    NSLog(@"=====%@=====",str);
    NSArray *array = [self.DataView visibleCells];
    
//    NSLog(@"array.count===%ld",array.count);
    
    for (DateCollectionViewCell *cell in array) {
        if ([cell.weekLabel.text isEqualToString:str]) {
            _PointView.center = cell.center;
        }
    }
    
    
    
    
}


@end
