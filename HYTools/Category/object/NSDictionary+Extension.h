//
//  NSDictionary+Extension.h
//  HYTools
//
//  Created by 胡杨 on 2017/5/11.
//  Copyright © 2017年 net.fitcome.www. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)
// 去除字典里的空值
- (id)processDictionaryIsNSNull:(id)obj;

@end




@interface NSArray (Extension)

/**防止数组取值越界*/
- (id)fc_objectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (Extension)

/**防止数组取值越界*/
- (id)fc_objectAtIndex:(NSUInteger)index;

- (void)fc_addObject:(id)anObject;

- (void)fc_insertObject:(id)anObject atIndex:(NSUInteger)index;

- (void)fc_removeObjectAtIndex:(NSUInteger)index;

@end
