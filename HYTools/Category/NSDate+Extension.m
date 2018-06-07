//
//  NSDate+Extension.m
//  HYTools
//
//  Created by Hoo on 2018/6/6.
//  Copyright © 2018年 net.fitcome.www. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

/**
 *  将0时区的时间转成0时区的时间戳
 */
+ (NSString *)transformToTimestampWithDate:(NSDate *)date{
    NSTimeInterval inter = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%ld", (long)inter];
}

/**
 *  将0时区的时间戳转成0时区的时间
 */
+ (NSDate *)transformToDateWithTimestamp:(NSString *)timestamp{
    NSTimeInterval inter = [timestamp doubleValue];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:inter];
    return date;
}

/**
 *  将0时区的时间戳转成8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithTimestamp:(NSString *)timestamp{
    //1.先将时间戳->NSDate
    NSDate *date = [self transformToDateWithTimestamp:timestamp];
    //2.将date->NSString
    return [[self transformToStringWithDate:date] substringToIndex:16];
}


/**
 *  将0时区的时间戳(10位数)转成8时区的时间文本格式（“2012-12-12 12：12”）,带有只有时分的
 */
+ (NSString *)transformToHourMiniteFormatWithTimestamp:(NSString *)timestamp{
    //1.先将时间戳->NSDate
    NSDate *date = [self transformToDateWithTimestamp:timestamp];
    //2.将date->NSString
    return [[self transformToStringWithDate:date] substringToIndex:13];
}

/**
 *  将8时区的时间文本格式（“2015-12-13 13：34：45”）转成 0时区的时间戳
 */
+ (NSString *)transformToTimestampWithString:(NSString *)string{
    //1.先将NSString->NSDate
    NSDate *date = [self transformToDateWithString:string];
    //2.将date->timestamp
    return [self transformToStringWithDate:date];
}

/**
 *  将8时区的时间文本格式（“2015-12-13 13：34：45”）转成 0时区的NSDate
 */
+ (NSDate *)transformToDateWithString:(NSString *)string{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [df dateFromString:string];
    return date;
}

/**
 *  将0时区的NSDate转成 8时区的时间文本格式（“2015-12-13 13：34：45”）
 */
+ (NSString *)transformToStringWithDate:(NSDate *)date{
//    NSDate *date = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    NSLog(@"enddate=%@",localeDate);
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [df stringFromDate:date];
    return string;
}


/**
 判断某个时间是否为今年
 */
- (BOOL)isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取年
    NSCalendarUnit unit = NSCalendarUnitYear;
    
    // 获得某个时间的年月日时分秒
    NSDateComponents *dateCmps = [calendar components:unit fromDate:self];
    
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    return dateCmps.year == nowCmps.year;
}

/**
 判断某个时间是否为昨天
 */
- (BOOL)isYesterday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // 把日期后面的 HH:mm:ss 抹掉，变成 00:00:00
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now = [NSDate date];
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return (cmps.year == 0 && cmps.month == 0 && cmps.day == 1);
}


/**
 判断某个时间是否为今天
 */
- (BOOL)isToday {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 把日期后面的 HH:mm:ss 变成 00:00:00
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSDate *now = [NSDate date];
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

@end
