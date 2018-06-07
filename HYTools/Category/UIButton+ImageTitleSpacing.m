//
//  UIButton+ImageTitleSpacing.m
//  HYTools
//
//  Created by Hoo on 2018/6/6.
//  Copyright © 2018年 net.fitcome.www. All rights reserved.
//

#import "UIButton+ImageTitleSpacing.h"
#import "MacroDefinition.h"

@implementation UIButton (ImageTitleSpacing)


- (void)layoutTabBarItemButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                                  imageTitleSpace:(CGFloat)space{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case DDButtonEdgeInsetsStyleTop:
        {
            if (isiPhoneX()) {
                imageEdgeInsets = UIEdgeInsetsMake((-labelHeight+space/2.0)-5, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, (-imageHeight-space/2.0)+4, 0);
            }else{
                imageEdgeInsets = UIEdgeInsetsMake((-labelHeight+space/2.0)-5, 0, 0, -labelWidth);
                labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
            }
        }
            break;
        case DDButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case DDButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case DDButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

- (void)layoutButtonWithEdgeInsetsStyle:(DDButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space{
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case DDButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case DDButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case DDButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case DDButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
//- (void)setBadge:(NSString *)number{
//
//    //刷新UI
//    CGFloat width = 50*kScaleHeight;
//    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(width*2/3, -width/12, width/2, width/2)];
//    badge.text = number;
//    badge.textAlignment = NSTextAlignmentCenter;
//    badge.font = PFR14Font;
//    badge.backgroundColor = ;
//    badge.textColor = CCBgColor;
//    badge.layer.cornerRadius = width/4;
//    badge.layer.masksToBounds = YES;
//    [self addSubview:badge];
//}
//- (void)RedBadge:(BOOL)iSShow
//{
//    //刷新UI
//    CGFloat width = 10;
//    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, 10, 10)];
//    badge.backgroundColor = CCRedColor;
//    badge.layer.cornerRadius = width/2;
//    badge.layer.masksToBounds = YES;
//    badge.hidden = iSShow;
//    [self addSubview:badge];
//}
//- (void)CartBadge:(NSString *)number{
//
//    UILabel *badge = [[UILabel alloc] initWithFrame:CGRectMake(30, 2, 20, 20)];
//    badge.text = number;
//    badge.textAlignment = NSTextAlignmentCenter;
//    badge.font = PFR12Font;
//    badge.backgroundColor = CCRedColor;
//    badge.textColor = CCBgColor;
//    badge.layer.cornerRadius = 10;
//    badge.layer.masksToBounds = YES;
//    [self addSubview:badge];
//}
-(void)changeSizeForButton:(UIButton *)button withString:(NSString *)text withFont:(id)font
{
    NSMutableAttributedString *mAttStri = [[NSMutableAttributedString alloc] initWithString:button.titleLabel.text];
    NSRange range = [button.titleLabel.text rangeOfString:text];
    [mAttStri addAttribute:NSFontAttributeName value:font range:range];
    button.titleLabel.attributedText=mAttStri;
}
/* 按钮弹一下的动画 */
- (void)centerAnnotationAnimimate
{
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGPoint center = self.center;
                         center.y -= 20;
                         [self setCenter:center];}
                     completion:nil];
    
    [UIView animateWithDuration:0.45
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGPoint center = self.center;
                         center.y += 20;
                         [self setCenter:center];}
                     completion:nil];
}

@end
