//
//  CalendarOBJ.h
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/20.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DateModel.h"


@interface CalendarOBJ : NSObject

-(NSInteger)getNumberOfThisMonth;
-(NSMutableArray *)getStringOfDate;
-(NSMutableArray *)getStringOfDateWithDate:(NSDate *)date_new;
@end
