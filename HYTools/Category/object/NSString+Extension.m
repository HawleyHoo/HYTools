//
//  NSString+Extension.m
//  微博
//
//  Created by 崔宇轩 on 15/8/2.
//  Copyright (c) 2015年 崔宇轩. All rights reserved.
//

#import "NSString+Extension.h"
#import "CommonCrypto/CommonDigest.h"
#import <CoreGraphics/CGContext.h>
#import "NSData+JSON.h"

@implementation NSString (Extension)

/**    正则表达式匹配通用方法    */
- (BOOL)matchRegularExpressionWithFormat:(NSString *)match{
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", match];
    return [regextestmobile evaluateWithObject:self];
}


- (NSURL *)URL {
    return [NSURL URLWithString:self];
}





- (NSString *)MD5Value {
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ].lowercaseString;
}
// base64 转码 解码
- (NSString *)base64String {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
- (NSString *)base64DecodeString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:0];
}


/** 字符串去掉前后空格 */
- (NSString *)stringRemovedBlankPrefixAndSuffix {
    return self.stringRemovedBlankPrefix.stringRemovedBlankSuffix;
}

- (NSString *)stringRemovedBlankPrefix {
    if ([self hasPrefix:@" "]) {
        NSRange range = NSMakeRange(1, self.length - 1);
        return [self substringWithRange:range].stringRemovedBlankPrefix;
    } else {
        return self;
    }
}

- (NSString *)stringRemovedBlankSuffix {
    if ([self hasSuffix:@" "]) {
        NSRange range = NSMakeRange(0, self.length - 1);
        return [self substringWithRange:range].stringRemovedBlankSuffix;
    } else {
        return self;
    }
}

- (NSString *)dateFormatString {
    return [NSString stringWithFormat:@"%02ld", (long)self.integerValue];
//    if (self.length == 1) {
//        return [NSString stringWithFormat:@"0%@", self];
//    } else if (self.length == 2) {
//        return self;
//    } else if (self.length == 0) {
//        return @"00";
//    } else {
//        return [self substringToIndex:2];
//    }
}


+ (NSString *)dateFormatStringWithValue:(NSInteger)value {
    return [NSString stringWithFormat:@"%02ld", (long)value];
}

/**
 根据文本和字体返回文本宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/**
 根据文本、字体、约束范围，返回文本范围
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW {
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize newSize = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return CGSizeMake(ceil(newSize.width), ceil(newSize.height));
}

/**
 根据format正则表达式规则判断字符串是否有效
 */
- (BOOL)isValidWithFormat:(NSString *)format {
    NSRange range = [self rangeOfString:format options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}



NSString *IntegerTypeBundleShortVersionString() {
    NSString *str = NSBundle.mainBundle.infoDictionary[@"CFBundleShortVersionString"];
    NSMutableString *mStr = [NSMutableString new];
    NSArray *array = [str componentsSeparatedByString:@"."];
    NSString *subStr0 = array[0];
    subStr0 = [NSString stringWithFormat:@"%zd", subStr0.integerValue * 10000];
    [mStr appendString:subStr0];
    NSString *subStr1 = array[1];
    subStr1 = [NSString stringWithFormat:@"%zd", subStr1.integerValue * 100];
    [mStr appendString:subStr1];
    NSString *subStr2 = array[1];
    subStr2 = [NSString stringWithFormat:@"%zd", subStr2.integerValue];
    [mStr appendString:subStr2];
    return mStr.copy;
}

/**检查是否有表情符号*/
- (BOOL)hasEmoji {
    __block BOOL isEomji = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring,
                                       NSRange substringRange,
                                       NSRange enclosingRange,
                                       BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0]; // surrogate pair
         if (0xd800 <= hs&&hs<= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc&&uc<= 0x1f77f) {
                     isEomji = YES;
                     *stop = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 isEomji = YES;
                 *stop = YES;
             }
         } else { // non surrogate
             if (0x2100 <= hs&&hs<= 0x27ff &&hs != 0x263b) {
                 isEomji = YES;
                 *stop = YES;
             } else if (0x2B05 <= hs&&hs<= 0x2b07) {
                 isEomji = YES;
                 *stop = YES;
             } else if (0x2934 <= hs&&hs<= 0x2935) {
                 isEomji = YES;
                 *stop = YES;
             } else if (0x3297 <= hs&&hs<= 0x3299) {
                 isEomji = YES;
                 *stop = YES;
             } else if (hs == 0xa9 || hs == 0xae ||
                        hs == 0x303d || hs == 0x3030||
                        hs == 0x2b55 || hs == 0x2b1c ||
                        hs == 0x2b1b || hs == 0x2b50||
                        hs ==0x231a ) {
                 isEomji = YES;
                 *stop = YES;
             }
         }
     }];
    //    return YES;
    return isEomji;
}

/**汉字，字母和数字*/
- (BOOL)isValidName {
    NSString *format = @"^[_a-zA-Z\\d\\s+\u4E00-\u9FA5]{1,8}$";
    
    NSRange range = [self rangeOfString:format options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        if ([self hasPrefix:@" "] || [self hasSuffix:@" "]) {
            return NO;
        } else {
            return YES;
        }
    }
}

/**汉字，字母和数字*/
- (BOOL)isValidNameWithSymbolCharacter {
    NSString *format = @"^[_a-zA-Z\\d\\s+\u4E00-\u9FA5\\.\\-~!@#$%^&*+?:_/=<>]{1,8}$";
    
    NSRange range = [self rangeOfString:format options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        if ([self hasPrefix:@" "] || [self hasSuffix:@" "]) {
            return NO;
        } else {
            return YES;
        }
    }
}


- (BOOL)isValidNameWithRange:(NSRange)range {
    NSString *format = [NSString stringWithFormat:@"^[_a-zA-Z\\d\u4E00-\u9FA5]{%zd,%zd}$", range.location, range.location + range.length];
    
    range = [self rangeOfString:format options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)im_isValidChatMessageString{
    return [self matchRegularExpressionWithFormat:@"^\\s*$"];
}


- (BOOL)im_hasEmoji{
    __block BOOL value = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              NSData *data = [substring dataUsingEncoding:NSUTF8StringEncoding];
                              if (data.length > 3) {
                                  value = YES;
                                  *stop = YES;
                              }
                          }];
    return value;
}


- (instancetype)im_removedEmojiString {
    NSMutableString* __block buffer = [NSMutableString stringWithCapacity:[self length]];
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock: ^(NSString* substring, NSRange substringRange, NSRange enclosingRange, BOOL* stop) {
                              [buffer appendString:([substring im_hasEmoji])? @"": substring];
                          }];
    return buffer.copy;
}

//- (BOOL)im_isValidNameString{
//    NSString * SPACE = @"^[\\u4e00-\\u9fa5a-zA-Z0-9]{1,8}";
//    return [self matchRegularExpressionWithFormat:SPACE];
//}


/**身份证号是否合法*/
- (BOOL)isValidIDCode {
    NSString *format = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X|x)$";
    
    NSRange range = [self rangeOfString:format options:NSRegularExpressionSearch];
    if (range.location == NSNotFound) {
        return NO;
    } else {
        NSInteger birthYear = [[self substringWithRange:NSMakeRange(6, 4)] integerValue];
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy"];
        
        NSInteger age = [[dateFormatter stringFromDate:currentDate] integerValue] - birthYear;
        
        if (age > 120 || age < 18) {
            return NO;
        }
        
        //判断日期是否存在
        range = NSMakeRange(6, 8);
        NSString *fullDateStr = [self substringWithRange:range];
        dateFormatter.dateFormat = @"yyyyMMdd";
        NSDate *date = [dateFormatter dateFromString:fullDateStr];
        if (date) {
            return YES;
        } else {
            return NO;
        }
    }
}

/**手机号是否合法*/
- (BOOL)isValidPhoneNumber {
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    //    JP
    
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    return [self matchRegularExpressionWithFormat:MOBILE];
}

- (BOOL)isValidNumber{
    NSString * num = @"^[0-9]*$";
    return [self matchRegularExpressionWithFormat:num];
}


- (BOOL)isValidURL{
    NSString * url = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    return [self matchRegularExpressionWithFormat:url];
}

/**账号是不是纯数字*/
- (BOOL)isValidAccountNumber{
    return self.isValidPhoneNumber;
}



/**汉字的拼音*/
- (NSString *)pinyin{
//    NSMutableString *str = [self mutableCopy];
//    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
//    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
//    return [[str stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
    
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    mutableString = (NSMutableString *)[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    if ([self hasPrefix:@"曾"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"z"];
    } else if ([self hasPrefix:@"覃"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"q"];
    } else if ([self hasPrefix:@"重"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"c"];
    } else if ([self hasPrefix:@"厦"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"x"];
    } else if ([self hasPrefix:@"秘"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"b"];
    } else if ([self hasPrefix:@"单"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(0, 1) withString:@"s"];
    }
    return [[mutableString stringByReplacingOccurrencesOfString:@"'" withString:@""] lowercaseString];
}






+ (NSString *)timeIntervalStringSince1970{
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f",time];
}

+ (NSString *)IMCacheFolderWithName:(NSString *)folderName{
    NSString * cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]; ;
    NSString * folderPath = [cachePath stringByAppendingPathComponent:folderName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:folderPath]) {
        NSError * error;
        [[NSFileManager defaultManager]createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"创建缓存路径失败");
            return nil;
        }
    }
    return folderPath;
}



+ (long long)fileSizeAtFilePath:(NSString *)path{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    BOOL isDictionary ;
    BOOL fileExists = [fileManager fileExistsAtPath:path isDirectory:&isDictionary];
    if (fileExists == NO) {
        return 0;
    }
    
    if (isDictionary) {
        NSArray * subPaths = [fileManager contentsOfDirectoryAtPath:path error:nil];
        
        long long totalSize = 0;
        for (NSString * subPath in subPaths) {
            NSString * fullPath = [path stringByAppendingString:subPath];
            totalSize += [self fileSizeAtFilePath:fullPath];
        }
        return totalSize;
    } else {
        NSDictionary * userInfo = [fileManager attributesOfItemAtPath:path error:nil];
        return [userInfo[NSFileSize] longLongValue];
    }
}


- (CGSize)sizeWithFont:(UIFont *)font andFitSize:(CGSize)size{
    CGSize newSize;
    NSDictionary * attributes = @{NSFontAttributeName:font};
    newSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    return CGSizeMake(ceil(newSize.width), ceil(newSize.height));
}


- (CGSize)sizeForParagraphStyleWithFont:(UIFont *)font andMaxWidth:(CGFloat)maxW{
    CGSize newSize;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    paragraphStyle.lineSpacing = 5;
    paragraphStyle.paragraphSpacing = 0;
    NSDictionary * attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    
    newSize = [self boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil].size;
    return CGSizeMake(ceil(newSize.width), ceil(newSize.height));
}








/**    解析jsonstr   */
- (NSDictionary *)parseJSONStr {
    
    if([self respondsToSelector:@selector(length)]){
        if (self.length == 0) {
            return nil;
        }
    } else {
        NSLog(@"Json解析出错：非NSString类型对象 \n%@",self);
        return nil;
    }
    
    // 替换特殊字符
    NSString *jsonString = self.copy;
    if ([self containsString:@"\r\n"] && ![self containsString:@"\\r\\n"]) {
        jsonString = [[self stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\\r\\n"] copy];
    } else if ([self containsString:@"\r\r"] && ![self containsString:@"\\r\\r"]){
        jsonString = [[self stringByReplacingOccurrencesOfString:@"\r\r" withString:@"\\r\\r"] copy];
    }
    
    
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError * parseError;
    NSDictionary *object = [NSJSONSerialization JSONObjectWithData:jsonData
                                                options:NSJSONReadingMutableContainers
                                                  error:&parseError];
    if(parseError) {
        NSLog(@"Json解析失败：【error】: %@\n\n【字符串】:%@",[parseError localizedDescription],self);
        if (parseError.code == 3840) {
            NSMutableDictionary *dic = jsonData.dictionaryOfRemovedESC;
            return dic;
        } else {
            return nil;
        }
    }
    return object;
}

- (NSString *)convertToJsonData:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonStr;
    if (error) {
        NSLog(@"error %@", jsonData);
    } else {
        jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonStr];
    
    //去掉字符串中的空格和换行符
    NSString *newStr = [mutStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return newStr;
}

- (BOOL)isCurrentDay{
    double timeIII = [self doubleValue];
    NSCalendar * calendar         = [NSCalendar currentCalendar];
    
    NSInteger unitFlags           = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate * currentDate          = [NSDate date];
    NSDateComponents *components  = [calendar components:unitFlags fromDate:currentDate];
    
    
    NSInteger currentDay          = components.day;
    NSInteger currentYear         = components.year;
    NSInteger currentMonth        = components.month;
    
    NSDate * msgDate              = [NSDate dateWithTimeIntervalSince1970:timeIII];
    components                    = [calendar components:unitFlags fromDate:msgDate];
    
    NSInteger msgDay              = components.day;
    NSInteger msgYear             = components.year;
    NSInteger msgMonth            = components.month;
    
    // 同一天
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        return YES;
    }
    return NO;
}


- (NSString *)dateStringForTimeIntel {
    double timeIII = [self doubleValue];
    NSCalendar * calendar         = [NSCalendar currentCalendar];
    
    NSInteger unitFlags           = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate * currentDate          = [NSDate date];
    NSDateComponents *components  = [calendar components:unitFlags fromDate:currentDate];
    
    
    NSInteger currentDay          = components.day;
    NSInteger currentYear         = components.year;
    NSInteger currentMonth        = components.month;
    
    NSDate * msgDate              = [NSDate dateWithTimeIntervalSince1970:timeIII];
    components                    = [calendar components:unitFlags fromDate:msgDate];
    
    NSInteger msgDay              = components.day;
    NSInteger msgYear             = components.year;
    NSInteger msgMonth            = components.month;
    
    // 同一天
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        dateFormatter.dateFormat = [NSString stringWithFormat:@"HH:mm"];
        // 昨天
    } else if (currentYear == msgYear && currentMonth == msgMonth && currentDay - msgDay == 1){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"昨天 HH:mm"];
        // 同年
    } else if (currentYear == msgYear){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"M月dd日"];
        // 其他
    } else {
        dateFormatter.dateFormat = @"yyyy年M月dd日";
    }
    
    return [dateFormatter stringFromDate:msgDate];
}

- (NSString *)dateStringForChatHistory{
    double timeIII = [self doubleValue];
    NSCalendar * calendar         = [NSCalendar currentCalendar];
    
    NSInteger unitFlags           = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday| NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDate * currentDate          = [NSDate date];
    NSDateComponents *components  = [calendar components:unitFlags fromDate:currentDate];
    
    
    NSInteger currentDay          = components.day;
    //    NSInteger currentWeek         = components.weekOfYear;
    NSInteger currentYear         = components.year;
    NSInteger currentMonth        = components.month;
    
    NSDate * msgDate              = [NSDate dateWithTimeIntervalSince1970:timeIII];
    components                    = [calendar components:unitFlags fromDate:msgDate];
    
    NSInteger msgDay              = components.day;
    //    NSInteger msgWeek             = components.weekOfYear;
    NSInteger msgYear             = components.year;
    //    NSInteger msgWeekDay          = components.weekday-1;
    NSInteger msgMonth            = components.month;
    //    NSInteger msgHour             = components.hour;
    
    //    NSString *noonStr;
    //    if (msgHour < 12) {
    //        noonStr = @"上午";
    //    } else {
    //        noonStr = @"下午";
    //    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 同一天
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        dateFormatter.dateFormat = [NSString stringWithFormat:@"HH:mm"];
        // 昨天
    } else if (currentYear == msgYear && currentMonth == msgMonth && currentDay - msgDay == 1){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"昨天 HH:mm"];
        // 同年
    } else if (currentYear == msgYear){
        //        NSArray * weekdayArray = @[@"周日",@"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
        //        NSString * weekStr = [weekdayArray objectAtIndex:msgWeekDay];
        //        NetworkManager.calendarDateFormatter.dateFormat = [NSString stringWithFormat:@"%@ HH:mm",weekStr];
        
        dateFormatter.dateFormat = [NSString stringWithFormat:@"M月d日"];
        // 其他
    } else {
        dateFormatter.dateFormat = @"yyyy年M月d日";
    }
    
    return [dateFormatter stringFromDate:msgDate];
}

- (NSString *)originFaceUrlForIM {
    if ([self containsString:@"/profile/face"]) {
        if ([self containsString:@"&os=iOS"]) {
            NSString *str = [self stringByReplacingOccurrencesOfString:@"&os=iOS" withString:@""];
            if ([str containsString:@"&size=1"]) {
                return [str stringByReplacingOccurrencesOfString:@"&size=1" withString:@""];
            } else {
                return str;
            }
        }
    }
    return self;
}

- (NSString *)smallFaceUrlForIM {
    if ([self containsString:@"/profile/face"]) {
        if ([self containsString:@"&os=iOS"]) {
            if ([self containsString:@"&size=1"]) {
                return [self stringByReplacingOccurrencesOfString:@"&size=1" withString:@"&size=0"];
            } else {
                return [self stringByAppendingString:@"&size=0"];
            }
        } else {
            return [self stringByAppendingString:@"&os=iOS&size=0"];
        }
    }
    return self;
}

- (NSString *)midFaceUrlForIM{
    if ([self containsString:@"/profile/face"]) {
        if ([self containsString:@"&os=iOS"]) {
            if ([self containsString:@"&size=1"]) {
                return self;
            } else {
                return [self stringByAppendingString:@"&size=1"];
            }
        } else {
            return [self stringByAppendingString:@"&os=iOS&size=1"];
        }
    }
    return self;
}

- (NSString *)bigFaceUrlForIM{
    if ([self containsString:@"/profile/face"]) {
        if ([self containsString:@"&os=iOS"]) {
            if ([self containsString:@"&size=1"]) {
                return [self stringByReplacingOccurrencesOfString:@"&size=1" withString:@"&size=2"];
            } else {
                return [self stringByAppendingString:@"&size=2"];
            }
        } else {
            return [self stringByAppendingString:@"&os=iOS&size=2"];
        }
    }
    return self;
}

- (UIColor *)RGBColor{
    //  #ff21af64
    if ([self hasPrefix:@"#"] && self.length == 9) {
        
        NSMutableString * colorString = [self mutableCopy];
        [colorString deleteCharactersInRange:NSMakeRange(0, 1)];
        
        NSString * alphaString = [colorString substringWithRange:NSMakeRange(0, 2)];
        NSString * redString   = [colorString substringWithRange:NSMakeRange(2, 2)];
        NSString * greenString = [colorString substringWithRange:NSMakeRange(4, 2)];
        NSString * blueString  = [colorString substringWithRange:NSMakeRange(6, 2)];
        
        unsigned long red   = strtoul([redString UTF8String], 0, 16);
        unsigned long green = strtoul([greenString UTF8String], 0, 16);
        unsigned long blue  = strtoul([blueString UTF8String], 0, 16);
        unsigned long alpha  = strtoul([alphaString UTF8String], 0, 16);
        
        UIColor * color = [UIColor colorWithRed:(float)red/ 255.0
                                          green:(float)green/ 255.0
                                           blue:(float)blue/ 255.0
                                          alpha:(float)alpha/ 255.0];
        return color;
    } else if ([self hasPrefix:@"#"] && self.length == 7){
        
        NSMutableString * colorString = [self mutableCopy];
        [colorString deleteCharactersInRange:NSMakeRange(0, 1)];
        
        NSString * redString   = [colorString substringWithRange:NSMakeRange(0, 2)];
        NSString * greenString = [colorString substringWithRange:NSMakeRange(2, 2)];
        NSString * blueString  = [colorString substringWithRange:NSMakeRange(4, 2)];
        
        unsigned long red   = strtoul([redString UTF8String], 0, 16);
        unsigned long green = strtoul([greenString UTF8String], 0, 16);
        unsigned long blue  = strtoul([blueString UTF8String], 0, 16);
        
        UIColor * color = [UIColor colorWithRed:(float)red/ 255.0
                                          green:(float)green/ 255.0
                                           blue:(float)blue/ 255.0
                                          alpha:1.0];
        return color;
        
    } else if ([self hasPrefix:@"0x"]) {
        
        unsigned long rgb = strtoul([self UTF8String], 0, 16);
        return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0
                               green:((float)((rgb & 0xFF00) >> 16))/255.0
                                blue:((float)((rgb & 0xFF) >> 16))/255.0
                               alpha:1.0];
    }
    return nil;
}





// 将阿拉伯数组转为汉字
NSString * NSMakeCNNumber(NSInteger number) {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    return [formatter stringFromNumber:[NSNumber numberWithInteger:number]];
}

NSString *NSStringWithFormat(NSString *format, ...) {
    va_list argptr;
    va_start(argptr, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:argptr];
    va_end(argptr);
    return str;
}

@end


