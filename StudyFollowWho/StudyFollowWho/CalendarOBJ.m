//
//  CalendarOBJ.m
//  StudyFollowWho
//
//  Created by 唐仁于 on 2018/6/20.
//  Copyright © 2018年 唐仁于. All rights reserved.
//

#import "CalendarOBJ.h"

@implementation CalendarOBJ



-(NSInteger)getNumberOfThisMonth
{
    NSCalendar *calender =[NSCalendar currentCalendar];
    //[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSDate *currentDate = [NSDate date];
    NSRange range = [calender rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:currentDate];
    return range.length;
    
}

-(NSInteger)getNumberOfMonth:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
//获取当前日期的字符串
-(NSMutableArray *)getStringOfDate
{
    NSDate *currentDate = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:currentDate];
 
    NSInteger weekDay = [components weekday];
    
    NSLog(@"first===%ld",[calendar firstWeekday]);
    
    NSInteger firstDayOff,lastDayOff;
    
    if (weekDay == 1) {
        firstDayOff = 1;
        lastDayOff = 6;
    }else{
        firstDayOff = [calendar firstWeekday] - weekDay;
        lastDayOff = 7 - weekDay;
    }
    
    NSMutableArray *arrayOfMonth = [NSMutableArray array];
    for (NSInteger i = firstDayOff - 7; i<lastDayOff + 1 + 7; i++) {
        
        NSTimeInterval dayNum = i*24*60*60;
        
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:dayNum];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd"];
       
        
        NSCalendar *Calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *someComponent = [Calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date];
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc]init];
        
        [weekFormatter setDateFormat:@"EEEE"];
        
        NSString *weekStr = [weekFormatter stringFromDate:date];

        DateModel *model = [[DateModel alloc]init];
        
        model.year = [someComponent year];
        
        model.month = [someComponent month];
        
        model.weekDay = weekStr;
        
        model.day = [someComponent day];
        
        model.Date = date;
        
        [arrayOfMonth addObject:model];
    }
    
    return arrayOfMonth;
}


//获取上一个月或者下一个月的日期
-(NSMutableArray *)getStringOfDateWithDate:(NSDate *)date_new
{
//    NSTimeInterval nextDay = 24*60*60;
//    NSDate *date = [NSDate dateWithTimeInterval:nextDay sinceDate:date_new];
   
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth|NSCalendarUnitYear|NSCalendarUnitDay) fromDate:date_new];
    
    NSInteger weekDay = [components weekday];
    
    NSLog(@"first===%ld",[calendar firstWeekday]);

    
    NSInteger firstDayOff,lastDayOff;
    
    if (weekDay == 1) {
        firstDayOff = 1;
        lastDayOff = 0;
    }else{
        firstDayOff = [calendar firstWeekday] - weekDay;
        lastDayOff = 7 - weekDay;
    }
    
    NSMutableArray *arrayOfMonth = [NSMutableArray array];
    for (NSInteger i= firstDayOff - 7; i<lastDayOff + 1 + 7; i++) {
        
        NSTimeInterval dayNum = i*24*60*60;
        
        NSDate *date_for_array = [NSDate dateWithTimeInterval:dayNum sinceDate:date_new];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        
        [formatter setDateFormat:@"yyyy-MM-dd"];
        
        
        NSCalendar *Calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateComponents *someComponent = [Calendar components:(NSCalendarUnitWeekday|NSCalendarUnitMonth |NSCalendarUnitYear | NSCalendarUnitDay) fromDate:date_for_array];
        
        NSDateFormatter *weekFormatter = [[NSDateFormatter alloc]init];
        
        [weekFormatter setDateFormat:@"EEEE"];
        
        NSString *weekStr = [weekFormatter stringFromDate:date_for_array];
        
        DateModel *model = [[DateModel alloc]init];
        
        model.year = [someComponent year];
        
        model.month = [someComponent month];
        
        model.weekDay = weekStr;
        
        model.day = [someComponent day];
        
        model.Date = date_for_array;
        
        [arrayOfMonth addObject:model];
    }
    
    return arrayOfMonth;
   
}

@end
