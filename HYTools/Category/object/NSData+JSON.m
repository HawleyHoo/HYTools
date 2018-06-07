//
//  NSData+JSON.m
//  HYTools
//
//  Created by Hoo on 2018/6/6.
//  Copyright © 2018年 net.fitcome.www. All rights reserved.
//

#import "NSData+JSON.h"

@implementation NSData (JSON)


- (NSDictionary *)dictionary {
    if (self) {
        NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
        str = [str stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
        str = [str stringByReplacingOccurrencesOfString:@"\"\"\"\"" withString:@"\"\""];
        
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            NSLog(@"(NSData 转 NSString)self:%@ \n error:%@", str, error);
        }
        return dic.copy;
    } else {
        return nil;
    }
}

// 去掉json中的换行符
- (NSMutableDictionary *)dictionaryOfRemovedESC {
    if (self) {
        NSString *jsonString = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
        
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\a" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\b" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\f" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\v" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        NSData* newData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:newData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];
        return dic;
    } else {
        return nil;
    }
}


- (NSString *)stringOfRemovedESC {
    if (self) {
        NSString *jsonString = [[NSString alloc] initWithData:self
                                                     encoding:NSUTF8StringEncoding];
        
        [jsonString dataUsingEncoding:NSASCIIStringEncoding];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\a" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\b" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\f" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\t" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\v" withString:@""];
        jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
        
        return jsonString;
    } else {
        return nil;
    }
}

- (NSString *)bluetoothStringOfRemovedESC {
    if (self) {
        NSString *string = [[NSString alloc] initWithData:self
                                                 encoding:NSUTF8StringEncoding];
        NSMutableString *responseString = [NSMutableString stringWithString:string];
        NSString *character = nil;
        
        NSLog(@"stringLength = %ld",(unsigned long)responseString.length);
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < responseString.length; i ++) {
            
            character = [responseString substringWithRange:NSMakeRange(i, 1)];
            
            // 1.创建正则表达式，数字大小写字母组成
            NSString *pattern = @"^[A-Za-z0-9]{1}+$";
            // 1.1将正则表达式设置为OC规则
            NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
            // 2.利用规则测试字符串获取匹配结果
            NSArray *results = [regular matchesInString:character options:0 range:NSMakeRange(0, character.length)];
            
            if (results.count != 0) {
                [tempArray addObject:results];
            }
        }
        
        if (tempArray.count != 0) {
            
            NSInteger len = responseString.length - tempArray.count;
            NSInteger loc = tempArray.count;
            [responseString deleteCharactersInRange:NSMakeRange(loc,len)];
        }
        
        return responseString;
    } else {
        return nil;
    }
}

@end
