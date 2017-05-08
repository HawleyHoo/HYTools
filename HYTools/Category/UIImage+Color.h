//
//  UIImage+Color.h
//  
//
//  Created by hy on 15/7/16.
//  Copyright (c) 2015年 Savvy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage*)imageWithColor:(UIColor*)color;
+ (UIImage*)imageWithColor:(UIColor*)color rect:(CGRect)rect;
+ (UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;

@end
