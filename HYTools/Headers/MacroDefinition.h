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



#endif
