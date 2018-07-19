//
//  DateCollectionViewCell.m
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/19.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "DateCollectionViewCell.h"

@implementation DateCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
    }
    
    return self;
}

-(void)creatDateLabelWithDate:(NSString *)date withWeek:(NSString *)week
{
    self.dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width/2)];
    self.dateLabel.font = [UIFont systemFontOfSize:14];
    self.dateLabel.clipsToBounds = YES;
    self.dateLabel.layer.cornerRadius = 22.5;
    self.dateLabel.textAlignment = NSTextAlignmentCenter;
    self.dateLabel.text = date;
    [self.contentView addSubview:self.dateLabel];
    
    self.weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.dateLabel.bounds.origin.y+self.dateLabel.frame.size.height, self.frame.size.width, self.frame.size.width/2)];
    self.weekLabel.font = [UIFont systemFontOfSize:10];

    self.weekLabel.clipsToBounds = YES;
    self.weekLabel.layer.cornerRadius = 22.5;
    self.weekLabel.textAlignment = NSTextAlignmentCenter;
    self.weekLabel.text = week;
    [self.contentView addSubview:self.weekLabel];
    
}



@end
