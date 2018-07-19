//
//  DateModel.h
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/24.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateModel : NSObject




@property(nonatomic,assign)NSInteger year;

@property(nonatomic,assign)NSInteger month;

@property(nonatomic,assign)NSInteger day;

@property(nonatomic,copy)NSString *weekDay;

@property(nonatomic,strong)NSArray *dateArray;

@property(nonatomic,strong)NSDate *Date;


@end
