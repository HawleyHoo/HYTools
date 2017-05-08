//
//  HYdDateFormatter.m
//  AiWoQi
//
//  Created by hy on 15/9/21.
//  Copyright (c) 2015年 Savvy. All rights reserved.
//

#import "HYDateFormatter.h"

@implementation HYDateFormatter

- (instancetype)getCurrentDateAndTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:date];
    self.year = [[str substringWithRange:NSMakeRange(2, 2)] intValue];
    self.month = [[str substringWithRange:NSMakeRange(4, 2)] intValue];
    self.day = [[str substringWithRange:NSMakeRange(6, 2)] intValue];
    self.hour = [[str substringWithRange:NSMakeRange(8, 2)] intValue];
    self.minute = [[str substringWithRange:NSMakeRange(10, 2)] intValue];
    self.second = [[str substringFromIndex:12] intValue];
    return self;
}
+ (instancetype)getCurrentDateAndTime
{
    return [[self alloc] getCurrentDateAndTime];
}


#pragma mark ---------
+ (NSString *)stringFromCurrentDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

//+ (NSString *)stringFromCurrentDateAndTime
//{
//    NSDate *date = [NSDate date];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *dateString = [formatter stringFromDate:date];
//    return dateString;
//}

+ (NSString *)previousDays:(NSInteger)days
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (days * 24 * 60 * 60)];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM.dd";
    return [formatter stringFromDate:date];
}



#pragma mark ---week
+ (NSString *)stringFromCurrentWeeks
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNum = [calendar ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSString *year = [formatter stringFromDate:date];
    NSString *weeks = [NSString stringWithFormat:@"%@-%ld", year, (long)weekNum];
    HYDateItem *item = [[HYDateItem alloc] init];
    item.date = weeks;
    /*
    NSTimeInterval interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    BOOL flag = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:date];
    if (flag) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 24 * 60 * 60];
    } else {
        NSLog(@" ************************************* ");
    }
    formatter.dateFormat = @"yyyyMMdd";
    NSString *start = [formatter stringFromDate:beginDate];
    item.year = [[start substringWithRange:NSMakeRange(2, 2)] intValue];
    item.startMonth = [[start substringWithRange:NSMakeRange(4, 2)] intValue];
    item.startDay = [[start substringWithRange:NSMakeRange(6, 2)] intValue];
    
    NSString *end = [formatter stringFromDate:endDate];
    item.year = [[end substringWithRange:NSMakeRange(2, 2)] intValue];
    item.endMonth = [[end substringWithRange:NSMakeRange(4, 2)] intValue];
    item.endDay = [[end substringWithRange:NSMakeRange(6, 2)] intValue];
    */
    return weeks;
}
+ (NSString *)stringFromPreviousWeeks:(NSInteger)num
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (num * 7 * 24 * 60 * 60)];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNum = [calendar ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSString *year = [formatter stringFromDate:date];
    NSString *weeks = [NSString stringWithFormat:@"%@-%ld", year, (long)weekNum];
    
    return weeks;
}

+ (NSArray *)getCurrentWeeks
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNum = [calendar ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSString *year = [formatter stringFromDate:date];
    NSString *weeks = [NSString stringWithFormat:@"%@-%ld", year, (long)weekNum];
    HYDateItem *item = [[HYDateItem alloc] init];
    item.date = weeks;
    
    NSTimeInterval interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    BOOL flag = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:date];
    if (flag) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 24 * 60 * 60];
    } else {
        NSLog(@" ************************************* ");
    }
    
    for (int index = 0; index < 7; index++) {
        
        NSDate *newDate = [beginDate dateByAddingTimeInterval:index * 24 * 60 * 60];
        formatter.dateFormat = @"yyyyMMdd";
        NSString *str = [formatter stringFromDate:newDate];
        [array addObject:str];
    }
    
    
    return array;
}

+ (NSArray *)previousWeeks:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (num * 7 * 24 * 60 * 60)];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger weekNum = [calendar ordinalityOfUnit:NSWeekCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy";
    NSString *year = [formatter stringFromDate:date];
    NSString *weeks = [NSString stringWithFormat:@"%@-%ld", year, (long)weekNum];
    HYDateItem *item = [[HYDateItem alloc] init];
    item.date = weeks;
    
    NSTimeInterval interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    BOOL flag = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginDate interval:&interval forDate:date];
    if (flag) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 24 * 60 * 60];
    } else {
        NSLog(@" ************************************* ");
    }
    
    for (int index = 0; index < 7; index++) {
        
        NSDate *newDate = [beginDate dateByAddingTimeInterval:index * 24 * 60 * 60];
        formatter.dateFormat = @"yyyyMMdd";
        NSString *str = [formatter stringFromDate:newDate];
        [array addObject:str];
    }
    
    
    return array;
}


#pragma mark ---month
+ (NSString *)stringFromCurrentMonths
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
+ (NSString *)stringFromPreviousMonths:(NSInteger)num
{
    NSDate *current = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger days = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:current];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (num * days * 24 * 60 * 60)];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM";
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}
+(NSRange)rangeOfMonth:(NSInteger)num
{
    NSDate *current = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger days = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:current];
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (num * days * 24 * 60 * 60)];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    return range;
}

+ (NSArray *)getCurrentMonths
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM";
    //NSString *month = [formatter stringFromDate:date];
    
    NSTimeInterval interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    BOOL flag = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:date];
    if (flag) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 24 * 60 * 60];
    } else {
        NSLog(@" ************************************* ");
    }
    
    
    for (int index = 0; index < range.length; index++) {
        
        NSDate *newDate = [beginDate dateByAddingTimeInterval:index * 24 * 60 * 60];
        formatter.dateFormat = @"yyyyMMdd";
        NSString *str = [formatter stringFromDate:newDate];
        [array addObject:str];
    }
    
    
    return array;

}

+ (NSArray *)previousMonths:(NSInteger)num
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSDate *current = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger days = [calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:current];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:- (num * days * 24 * 60 * 60)];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy.MM";
    
    
    NSTimeInterval interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    BOOL flag = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:date];
    if (flag) {
        endDate = [beginDate dateByAddingTimeInterval:interval - 24 * 60 * 60];
    } else {
        NSLog(@" ************************************* ");
    }
    NSLog(@"\n %@ \n %@", beginDate, endDate);
    
    for (int index = 0; index < range.length; index++) {
        
        NSDate *newDate = [beginDate dateByAddingTimeInterval:index * 24 * 60 * 60];
        formatter.dateFormat = @"yyyyMMdd";
        NSString *str = [formatter stringFromDate:newDate];
        [array addObject:str];
    }
    
    
    return array;
}


- (NSString *)description
{
    return [NSString stringWithFormat:@" %@ %d %02d %02d %02d %02d %02d ", [self class], self.year, self.month, self.day, self.hour, self.minute, self.second];
}
@end

@implementation HYDateItem

@end
