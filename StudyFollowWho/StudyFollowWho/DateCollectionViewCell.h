//
//  DateCollectionViewCell.h
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/19.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCollectionViewCell : UICollectionViewCell


@property (nonatomic,strong)UILabel *dateLabel;
@property (nonatomic,strong)UILabel *weekLabel;

-(void)creatDateLabelWithDate:(NSString *)date withWeek:(NSString *)week;

@end
