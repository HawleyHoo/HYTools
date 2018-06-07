//
//  NSObject+RuntimeExtension.h
//  
//
//  Created by 胡杨 on 16/8/16.
//  Copyright © 2016年 胡杨. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeExtension)


/**    字典转模型（单层结构，属性全转字符串）    */
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

/**    模型所有的属性名(只写setter和getter不会包含)    */
+ (NSArray *)propertyArrayFromModel;


/**    初始化方法    */
+ (instancetype)model;





/**
 *  Tips：用于替换同一类的2个方法，一般用于分类。建议放在+(void)load方法使用
 *
 *  @param originalSEL 被替换的目标SEL
 *  @param replaceSEL  用于替换的自定义SEL
 */
+ (void)exchangeMethodForCurrentClassWithOriginalSEL:(SEL)originalSEL replaceSEL:(SEL)replaceSEL;

@end

@interface NSDictionary (LOG)

@end


