//
//  UIButton+ImageTitleSpacing.h
//  HYTools
//
//  Created by Hoo on 2018/6/6.
//  Copyright © 2018年 net.fitcome.www. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, DDButtonEdgeInsetsStyle) {
    DDButtonEdgeInsetsStyleTop, // image在上，label在下
    DDButtonEdgeInsetsStyleLeft, // image在左，label在右
    DDButtonEdgeInsetsStyleBottom, // image在下，label在上
    DDButtonEdgeInsetsStyleRight // image在右，label在左
};
@interface UIButton (ImageTitleSpacing)

/**
*  设置BarItemButton的titleLabel和imageView的布局样式，及间距
*
*  @param style titleLabel和imageView的布局样式
*  @param space titleLabel和imageView的间距
*/
- (void)layoutTabBarItemButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                                  imageTitleSpace:(CGFloat)space;

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;

/**
 *  设置button的Badge,购物车件数
 *
 *  @param number 数量
 
 */
- (void)setBadge:(NSString *)number;

- (void)CartBadge:(NSString *)number;
/**
 *  消息按钮设置红点
 *
 *  @param iSShow 是否显示
 
 */
- (void)RedBadge:(BOOL)iSShow;
/**
 *改变UIButton中指定字符串的字体大小
 */
-(void)changeSizeForButton:(UIButton *)button withString:(NSString *)text withFont:(id)font;

/**
 *按钮弹一下的动画
 */
-(void)centerAnnotationAnimimate;

@end
