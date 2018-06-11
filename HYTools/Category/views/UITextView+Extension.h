//
//  UITextView+Extension.h
//  HYTools
//
//  Created by Hoo on 2018/6/8.
//  Copyright © 2018年 net.fitcome.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)


/**
 *  是否支持视图上移
 */
@property (nonatomic, assign) BOOL canMove;
/**
 *  点击回收键盘、移动的视图，默认是当前控制器的view
 */
@property (nonatomic, strong) UIView *moveView;
/**
 *  textfield底部距离键盘顶部的距离
 */
@property (nonatomic, assign) CGFloat heightToKeyboard;

@property (nonatomic, assign, readonly) CGFloat keyboardY;
@property (nonatomic, assign, readonly) CGFloat keyboardHeight;
@property (nonatomic, assign, readonly) CGFloat initialY;
@property (nonatomic, assign, readonly) CGFloat totalHeight;
@property (nonatomic, strong, readonly) UITapGestureRecognizer *tapGesture;
@property (nonatomic, assign, readonly) BOOL hasContentOffset;


@end
