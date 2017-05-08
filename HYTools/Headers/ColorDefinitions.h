//
//  ColorDefinitions.h
//
//
//  Created by HY on 2016/10/27.
//  Copyright © 2016年 . All rights reserved.
//

#ifndef ColorDefinitions_h
#define ColorDefinitions_h

#import <UIKit/UIKit.h>

#pragma mark - 颜色宏

static inline UIColor *RGBACOLOR(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)];
}

static inline UIColor *RGBCOLOR(CGFloat r, CGFloat g, CGFloat b) {
    return RGBACOLOR(r, g, b, 1);
}

// 16进制颜色 0xffffff
static inline UIColor *HEXACOLOR(NSUInteger HEXValue, CGFloat a) {
    return RGBACOLOR((HEXValue & 0xFF0000) >> 16,
                     (HEXValue & 0xFF00) >> 8,
                     HEXValue & 0xFF,
                     a);
}
static inline UIColor *HEXCOLOR(NSUInteger HEXValue) {
    return HEXACOLOR(HEXValue, 1);
}


static inline UIColor *ThemeColor() {
    return RGBCOLOR(12, 196, 120);
}

static inline UIColor *ThemeColourAlpha() {
    return RGBACOLOR(12, 196, 120, 0.1);
}

static inline UIColor *ThemeColourHighlighted() {
    return RGBCOLOR(15, 165, 103);
}

static inline UIColor *BlackGrayFontColour() {
    return RGBCOLOR(102, 102, 102);
}

static inline UIColor *BlackFontColor() {
    return RGBCOLOR(102, 102, 102);
}

// 标题颜色（黑色）
static inline UIColor *MainBlackFontColour() {
    return RGBCOLOR(51, 51, 51);
}
// 副标题（灰色）

static inline UIColor *GrayFontColor() {
    return RGBCOLOR(153, 153, 153);
}
// 警告、提示颜色（红色）

static inline UIColor *WarnFontColor() {
    return RGBCOLOR(246, 97, 90);
}
// 初级危险警告

static inline UIColor *LightWarnColor() {
    return RGBCOLOR(255, 132, 35);
}
// ebebeb

static inline UIColor *EBEBEBColor() {
    return RGBCOLOR(235, 235, 235);
}

#pragma mark- 自定义颜色
static inline UIColor *RectBorderGrayColor() {
    return RGBCOLOR(153, 153, 153);
}

static inline UIColor *NavBarTintColor() {
    return RGBCOLOR(120, 120, 120);
}

static inline UIColor *NavBarColor() {
    return RGBCOLOR(251, 251, 251);
}

static inline UIColor *LoginViewLabelFontColor() {
    return RGBCOLOR(50, 50, 50);
}

#pragma mark 系统颜色
static inline UIColor *UIWhiteColor() {
    return [UIColor whiteColor];
}
static inline UIColor *UILightGrayColor() {
    return [UIColor lightGrayColor];
}
static inline UIColor *UIGrayColor() {
    return [UIColor grayColor];
}
static inline UIColor *UIDarkGrayColor() {
    return [UIColor darkGrayColor];
}
static inline UIColor *UIBlackColor() {
    return [UIColor blackColor];
}
static inline UIColor *UIClearColor() {
    return [UIColor clearColor];
}
static inline UIColor *UIRedColor() {
    return [UIColor redColor];
}
static inline UIColor *UIGreenColor() {
    return [UIColor greenColor];
}
static inline UIColor *UIBlueColor() {
    return [UIColor blueColor];
}
static inline UIColor *UIYellowColor() {
    return [UIColor yellowColor];
}
static inline UIColor *UISystemButtonColor() {
    return RGBCOLOR(11, 95, 255);
}
static inline UIColor *UITableViewBackgroundColor() {
    return RGBCOLOR(239, 239, 244);
}

#endif /* ColorDefinitions_h */
