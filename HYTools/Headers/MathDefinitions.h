//
//  MathDefinitions.h
//
//
//  Created by  on 2016/10/27.
//  Copyright © 2016年  All rights reserved.
//

#ifndef MathDefinitions_h
#define MathDefinitions_h

#import <UIKit/UIKit.h>



static const NSInteger kUserNameMaxLength = 8;

static inline CGRect SCREENBOUNDS() {
    return [UIScreen mainScreen].bounds;
}

static inline CGSize SCREENSIZE() {
    return SCREENBOUNDS().size;
}

static inline CGFloat SCREENWIDTH() {
    return SCREENSIZE().width;
}

static inline CGFloat SCREENHEIGHT() {
    return SCREENSIZE().height;
}

static inline CGPoint SCREENCENTER() {
    return CGPointMake(SCREENWIDTH() * 0.5, SCREENHEIGHT() * 0.5);
}


// 向下取整  GetFloor(16.27, 0.1)   => 16.2
static inline float GetFloor(float value, float location) {
    return floorf(value * (1.0 / location)) / (1.0 / location);
}

// 向上取整  GetCeil(16.22, 0.1)    => 16.3
static inline float GetCeil(float value, float location) {
    return ceilf(value * (1.0 / location)) / (1.0 / location);
}

//  四舍五入 GetRound(3.1415926, 0.001)  => 3.142000
static inline float GetRound(float value, float location) {
    return round(value * (1.0 / location)) / (1.0 / location);
}

// 取相对宽度
static inline CGFloat RelativeWidth(CGFloat Width) {
    return Width * SCREENWIDTH() / 360.0;
}

// 取相对高度
static inline CGFloat RelativeHeight(CGFloat Height) {
    return Height * SCREENHEIGHT() / 640.0;
}

// 取相对宽度 按照像素取
static inline CGFloat RelativeW(CGFloat Width) {
    return Width * SCREENWIDTH() / 720.0;
}

// 取相对高度 按照像素取
static inline CGFloat RelativeH(CGFloat Height) {
    return Height * SCREENHEIGHT() / 1280.0;
}

// WKwebview progressview 的延迟消失时间
static const NSTimeInterval kWKwebviewProgressDelay = 0.2;

static const CGFloat CornerRadius = 6;
//网络请求超时时间

static inline double MAX_3(double A, double B, double C) {
    double result = A > B ? A : B;
    return result > C ? result : C;
}

static inline double MIN_3(double A, double B, double C) {
    double result = A < B ? A : B;
    return result < C ? result : C;
}

static const NSTimeInterval kNSURLRequestTimeOutInterval = 16;

#endif /* MathDefinitions_h */
