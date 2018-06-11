//
//  FCAccountModel.m
//  EDFMerchant
//
//  Created by Hoo on 2018/5/19.
//  Copyright © 2018年 EDF. All rights reserved.
//

#import "FCAccountModel.h"
#import <objc/runtime.h>
@implementation FCAccountModel


+ (instancetype)sharedModel {
    static dispatch_once_t once;
    static FCAccountModel *instanceType;
    dispatch_once(&once, ^{
        instanceType = [[self alloc] init];
    });
    return instanceType;
}



+ (void)configInfo:(NSDictionary *)infoDict {
    NSArray *allKeys = [infoDict allKeys];
    
    for (NSString *key in allKeys) {
        // access_token 已经设置了 此时infoDict中token为空
        if ([key isEqualToString:@"access_token"]) {
            return;
        }
        
        NSString *firstKey = [key substringToIndex:1];
        firstKey = [firstKey uppercaseString];
        NSString *lastKey = [key substringFromIndex:1];
        
        // 构造setter方法
        NSString *selectorStr = [NSString stringWithFormat:@"set%@%@:", firstKey, lastKey];
        SEL setSelector = NSSelectorFromString(selectorStr);
        
        NSString *value = [infoDict objectForKey:key];
        
        FCAccountModel *account = [FCAccountModel sharedModel];
        if ([account respondsToSelector:@selector(performSelector:withObject:)]) {
            [account performSelector:setSelector withObject:value];
        }
        //        IMP imp = [userInfo methodForSelector:setSelector];
        //        void (*func)(id, SEL, NSString *) = (void *)imp;
        //        func(userInfo, setSelector, value);
    }
    
}

+ (void)load {
    // 将属性的所有setter和getter方法与自定义方法互换
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = varList[i];
        
        const char *attr = ivar_getName(ivar);
        NSString *attrName = [NSString stringWithFormat:@"%s", attr];
        attrName = [attrName substringFromIndex:1];
        NSString *firstAttrName = [attrName substringToIndex:1];
        firstAttrName = [firstAttrName uppercaseString];
        NSString *lastAttrName = [attrName substringFromIndex:1];
        
        //构造原setter方法
        SEL originalSetSelector = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", firstAttrName, lastAttrName]);
        Method originalSetMethod = class_getInstanceMethod([self class], originalSetSelector);
        
        //构造原getter方法
        SEL originalGetSelector = NSSelectorFromString(attrName);
        Method originalGetMethod = class_getInstanceMethod([self class], originalGetSelector);
        
        //新setter方法
        SEL newSetSelector = @selector(setMyAttribute:);
        Method newSetMethod = class_getInstanceMethod([self class], newSetSelector);
        IMP newSetIMP = method_getImplementation(newSetMethod);
        //新getter方法
        SEL newGetSelector = @selector(getAttribute);
        Method newGetMethod = class_getInstanceMethod([self class], newGetSelector);
        IMP newGetIMP = method_getImplementation(newGetMethod);
        
        //Method Swizzling
        method_setImplementation(originalSetMethod, newSetIMP);
        method_setImplementation(originalGetMethod, newGetIMP);
    }
    
}

#pragma mark-自定义setter方法（将属性值都存储到用户偏好设置）
- (void)setMyAttribute:(id)attribute{
    
    //获取调用的方法名称
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    //对set方法进行属性字段的解析,并存储到用户偏好设置表
    NSString *attr = [selectorString substringFromIndex:3];
    attr = [attr substringToIndex:[attr length]-1];
    //对首字符进行小写
    NSString *firstChar = [attr substringToIndex:1];
    firstChar = [firstChar lowercaseString];
    NSString *lastAttri = [NSString stringWithFormat:@"%@%@",firstChar,[attr substringFromIndex:1]];
    [[NSUserDefaults standardUserDefaults] setObject:attribute forKey:lastAttri];
    
}

#pragma mark-自定义的getter方法（将属性值从用户偏好设置中取出）
- (id)getAttribute{
    
    //获取方法名
    NSString *selectorString = NSStringFromSelector(_cmd);
    
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:selectorString];
    if ([result isEqual:[NSNull null]]) {
        result = nil;
    }
    return result;
    
}


#pragma mark-用户登出操作
+ (void)loginOut{
    
    //清除本地信息
    NSArray *allAttribute =  [self getAllProperties];
    for (NSString *attribute in allAttribute) {
        
        [[NSUserDefaults standardUserDefaults]setObject:nil forKey:attribute];
        
    }
    
    
    
}

//获取用户信息类的所有属性
+ (NSArray *)getAllProperties
{
    u_int count;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}


@end
