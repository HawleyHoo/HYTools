//
//  NSDictionary+Extension.m
//  HYTools
//
//  Created by 胡杨 on 2017/5/11.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (id)processDictionaryIsNSNull:(id)obj {
    const NSString *blank = @"";
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *mutStr = [NSMutableString string];
    [mutStr appendString:@"{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [mutStr appendFormat:@"\n\t%@ = %@,",key,obj];
    }];
    //去掉最后一个逗号（,）
    if ([mutStr hasSuffix:@","]) {
        NSString *str = [mutStr substringToIndex:mutStr.length - 1];
        mutStr = [NSMutableString stringWithString:str];
    }
    [mutStr appendString:@"\n}"];
    return mutStr;
}
@end


@implementation NSArray (Extension)

- (id)fc_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
    //    if (index >= self.count) {
    //        return nil;
    //    }
    //    id value = [self objectAtIndex:index];
    //    if (value == [NSNull null]) {
    //        return nil;
    //    }
    //    NSNull是一个类，它只有一个方法：+ (NSNull *) null;
    //    [NSNull null]用来在NSArray和NSDictionary中加入非nil（表示列表结束）的空值.   [NSNull null]是一个对象，用来表示空，他用在不能使用nil的场合。
}

-(NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *msr = [NSMutableString string];
    [msr appendString:@"["];
    for (id obj in self) {
        [msr appendFormat:@"\n\t%@,",obj];
    }
    //去掉最后一个逗号（,）
    if ([msr hasSuffix:@","]) {
        NSString *str = [msr substringToIndex:msr.length - 1];
        msr = [NSMutableString stringWithString:str];
    }
    [msr appendString:@"\n]"];
    return msr;
}


@end

@implementation NSMutableArray (Extension)

- (id)fc_objectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (void)fc_addObject:(id)anObject {
    if (anObject != nil && [anObject isKindOfClass:[NSNull class]] == NO) {
        [self addObject:anObject];
    } else {
        NSLog(@"--------------fc_addObject:%@", [NSThread callStackSymbols]);
    }
}

- (void)fc_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index <= self.count && anObject != nil && [anObject isKindOfClass:[NSNull class]] == NO) {
        [self insertObject:anObject atIndex:index];
    } else {
        NSLog(@"--------------fc_insertObject:%@", [NSThread callStackSymbols]);
        
    }
}

- (void)fc_removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    } else {
        NSLog(@"--------------fc_removeObjectAtIndex:%@", [NSThread callStackSymbols]);
        
    }
}
@end


