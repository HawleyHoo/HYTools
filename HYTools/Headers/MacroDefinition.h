//
//  MacroDefinition.h
//  FitCome
//
//  Created by  on 15/7/27.
//  Copyright (c) 2015年 FitCome. All rights reserved.
//


#ifndef FitCome_MacroDefinition_h
#define FitCome_MacroDefinition_h

#import <UIKit/UIKit.h>
#import "MathDefinitions.h"



#define WEAKSELF typeof(self) __weak weakSelf = self
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf


//其他宏定义

#pragma mark- 其他宏定义
static inline NSString *CurrentDevice() {
    return [UIDevice currentDevice].model;
}
static inline BOOL isiPad() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
}
static inline BOOL isiPhone() {
    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
}
static inline BOOL iPhone4Or4S() {
    return SCREENHEIGHT() == 480;
}
static inline NSUserDefaults *USERDEFAULTS() {
    return [NSUserDefaults standardUserDefaults];
}
static inline NSNotificationCenter *NOTICENTER() {
    return [NSNotificationCenter defaultCenter];
}

static inline float kSystemVersion() {
    return [UIDevice currentDevice].systemVersion.floatValue;
}

static inline UIFont *NavTitleFont() {
    return [UIFont systemFontOfSize:20];
}
static inline UIFont *NavSideFont() {
    return [UIFont systemFontOfSize:16];
}
static inline NSValue *centerValue() {
    return [NSValue valueWithCGPoint:SCREENCENTER()];
}

//其他宏定义

#pragma mark- 其他宏定义
//static inline NSString *CurrentDevice() {
//    return [UIDevice currentDevice].model;
//}
//static inline BOOL isiPad() {
//    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
//}
//static inline BOOL isiPhone() {
//    return [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone;
//}
//static inline BOOL iPhone4Or4S() {
//    return SCREENHEIGHT() == 480;
//}

static inline BOOL isiPhoneX() {
    return CGSizeEqualToSize(SCREENSIZE(), CGSizeMake(375.f, 812.f)) || CGSizeEqualToSize(SCREENSIZE(), CGSizeMake(812.f, 375.f));
}

// 导航栏高度
static inline CGFloat kNavBarHeight() {
    return isiPhoneX() ? 88.0f : 64.0f;
}

static inline CGFloat kTabBarHeight() {
    return isiPhoneX() ? 83.0f : 49.0f;
}

//iPhone X竖屏时占满整个屏幕的控制器的view的safeAreaInsets是（44，0，34，0），横屏是（0，44，21，44），
//inset后的区域正好是safeAreaLayoutGuide区域
// iPhone X 底部安全高度
static inline CGFloat kiPhoneXBottomSafeHeight() {
    return isiPhoneX() ? 34.0f : 0;
}



#endif
