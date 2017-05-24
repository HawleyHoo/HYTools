//
//  NSObject+RuntimeExtension.m
//  
//
//  Created by 胡杨 on 16/8/16.
//  Copyright © 2016年 胡杨. All rights reserved.
//

#import "NSObject+RuntimeExtension.h"
#import <objc/runtime.h>

@implementation NSObject (RuntimeExtension)

- (NSDictionary *)dictionaryFromModel{
    NSMutableDictionary * mutDict = [[NSMutableDictionary alloc]init];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        //id value = [self valueForKey:name];
        
        SEL getter = NSSelectorFromString(name);
        if ([self respondsToSelector:getter]) {
            //id value = [self performSelector:getter];
            id value = [self valueForKey:name];
            if (value) {
                [mutDict setObject:value forKey:name];
            }
        }
    }
    free(properties);//class_copyPropertyList一定要释放
    return [mutDict copy];
}







+ (NSArray *)propertyArrayFromModel{
    NSMutableArray * propertyArray = [[NSMutableArray alloc]init];
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        objc_property_t property = properties[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        
        [propertyArray addObject:name];
    }
    free(properties);//class_copyPropertyList一定要释放
    return [propertyArray copy];
}


+ (instancetype)model{
    return [[self alloc]init];
}


#pragma mark - 方法转换

+ (void)exchangeMethodForCurrentClassWithOriginalSEL:(SEL)originalSEL replaceSEL:(SEL)replaceSEL{
    // 方法调换，实则调换2个方法实现，即调换IMP（方法以函数指针来表示，IMP指向方法实现）
    Method originalMethod = class_getInstanceMethod(self, originalSEL);
    Method replaceMethod = class_getInstanceMethod(self, replaceSEL);
    
    // 将customMethod的实现添加到systemMethod中，如果返回YES，说明没有实现customMethod，返回NO，已经实现了该方法
    BOOL add = class_addMethod(self, originalSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
    if (add) {
        // 没有实现customMethod,则需要将customMethod的实现指针换回systemMethod的
        class_replaceMethod(self, replaceSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        // 已经实现customMethod，则对systemMethod和customMethod的实现指针IMP进行交换
        // 交换一次就行，多次交换会出现混乱
        method_exchangeImplementations(originalMethod, replaceMethod);
    }
}






/** 有BUG，不要用
 *  Tips：用于A-B 2个类之间替换方法，在自定义的替换方法replaceSEL实现中，self是targetClass对象，并不是当前类对象。所以要用当前类的对象调用originalSEL。建议放在+(void)load方法或者单例Block中使用
 *
 *  @param targetClass 被替换方法的类
 *  @param originalSEL 被替换的目标SEL
 *  @param replaceSEL  用于替换的自定义SEL
 */
//+ (void)exchangeMethodBetweenCurrentClassAndAnotherClass:(Class)targetClass originalSEL:(SEL)originalSEL replaceSEL:(SEL)replaceSEL{
//    Method originalMethod = class_getInstanceMethod(targetClass, originalSEL);
//    Method replaceMethod = class_getInstanceMethod(self, replaceSEL);
//
//    BOOL add = class_addMethod(targetClass, originalSEL, method_getImplementation(replaceMethod), method_getTypeEncoding(replaceMethod));
//    if (add) {
//        class_replaceMethod(targetClass, replaceSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
//    } else {
//        method_exchangeImplementations(originalMethod, replaceMethod);
//    }
//}
//- (BOOL)jk_prefersStatusBarHidden{
//    // 这里面的self = IMChatViewController对象，无法调用JKPhotoManager里面的方法
//    if ([JKPhotoManager sharedPhoneManager].exchangeMethod) {
//        return [JKPhotoManager sharedPhoneManager].hidesStatusBar;
//    } else {
//        if ([self respondsToSelector:@selector(jk_prefersStatusBarHidden)]) {
//            return [self jk_prefersStatusBarHidden];
//        } else {
//            return [[JKPhotoManager sharedPhoneManager] jk_prefersStatusBarHidden];
//        }
//    }
//}
@end




@implementation NSDictionary (LOG)

+ (void)load {
#ifdef DEBUG
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self exchangeMethodForCurrentClassWithOriginalSEL:@selector(descriptionWithLocale:) replaceSEL:@selector(jk_descriptionWithLocale:)];
    });
#endif
}


- (NSString *)jk_descriptionWithLocale:(id)locale {
    if (self == nil || self.allKeys.count == 0) {
        return [self jk_descriptionWithLocale:locale];
    } else {
        @try {
            NSError * error = nil;
            NSData * data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
            if (error) {
                return [self jk_descriptionWithLocale:locale];
            } else {
                return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            }
        } @catch (NSException *exception) {
            return [self jk_descriptionWithLocale:locale];
        }
    }
}

@end
