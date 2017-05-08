//
//  HYdDateFormatter.h
//  AiWoQi
//
//  Created by hy on 15/9/21.
//  Copyright (c) 2015年 Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYDateItem : NSObject

@property (nonatomic, copy) NSString *date;

@property (nonatomic, assign) int year;
//@property (nonatomic, assign) int month;
@property (nonatomic, assign) int startMonth;
@property (nonatomic, assign) int startDay;

@property (nonatomic, assign) int endMonth;
@property (nonatomic, assign) int endDay;

@end


@interface HYDateFormatter : NSObject

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, assign) int hour;
@property (nonatomic, assign) int minute;
@property (nonatomic, assign) int second;


- (instancetype)getCurrentDateAndTime;
+ (instancetype)getCurrentDateAndTime;

+ (NSString *)stringFromCurrentDate;
+ (NSString *)previousDays:(NSInteger)days;


+ (NSString *)stringFromCurrentWeeks;
+ (NSString *)stringFromPreviousWeeks:(NSInteger)num;
+ (NSArray *)getCurrentWeeks;
+ (NSArray *)previousWeeks:(NSInteger)num;


+ (NSString *)stringFromCurrentMonths;
+ (NSString *)stringFromPreviousMonths:(NSInteger)num;
+ (NSRange)rangeOfMonth:(NSInteger)num;
+ (NSArray *)getCurrentMonths;
+ (NSArray *)previousMonths:(NSInteger)num;

@end


