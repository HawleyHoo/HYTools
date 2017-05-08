//
//  HYResourcePath.m
//
//
//  Created by hy on 15/4/21.
//  Copyright (c) 2015年 Savvy. All rights reserved.
//

#import "HYResourcePath.h"

NSString *GetDocumentPathWithFile(NSString *file)
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

NSString *GetCachePathWithFile(NSString *file)
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

NSString *GetTempPathWithFile(NSString *file)
{
    NSString *path = NSTemporaryDirectory();
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}


@implementation HYResourcePath

+ (NSString *)GetDocumentPathWithFile:(NSString *)file
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

+ (NSString *)GetCachePathWithFile:(NSString *)file;
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

+ (NSString *)GetTempPathWithFile:(NSString *)file
{
    NSString *path = NSTemporaryDirectory();
    
    if (file) {
        return [path stringByAppendingPathComponent:file];
    }
    
    return path;
}

@end
