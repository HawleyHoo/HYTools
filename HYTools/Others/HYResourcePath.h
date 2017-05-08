//
//  HYResourcePath.h
//
//
//  Created by hy on 15/4/21.
//  Copyright (c) 2015年 Savvy. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *GetDocumentPathWithFile(NSString *file);
NSString *GetCachePathWithFile(NSString *file);
NSString *GetTempPathWithFile(NSString *file);


@interface HYResourcePath : NSObject

+ (NSString *)GetDocumentPathWithFile:(NSString *)file;
+ (NSString *)GetCachePathWithFile:(NSString *)file;
+ (NSString *)GetTempPathWithFile:(NSString *)file;

@end
