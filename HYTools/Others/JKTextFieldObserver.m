//
//  IMTextFieldDelegate.m
//  珍夕
//
//  Created by  on 16/9/18.
//  Copyright © 2016年 . All rights reserved.
//

#import "JKTextFieldObserver.h"
#import "NSString+Emoji.h"
#import "NSString+Extension.h"


@interface JKTextFieldObserver ()

@property (nonatomic, copy)NSString * memoryAddress;


@end

@implementation JKTextFieldObserver

+ (instancetype)observerWithTextField:(UITextField *)textField{
    return [[JKTextFieldObserver alloc]initWithTextField:textField];
}

- (instancetype)initWithTextField:(UITextField *)textField{
    if (self = [super init]) {
        textField.accessibilityIdentifier = [NSString stringWithFormat:@"%p",self];
        self.memoryAddress = textField.accessibilityIdentifier;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeText:) name:UITextFieldTextDidChangeNotification object:nil];
    }return self;
}

- (BOOL)jk_textField:(UITextField *)textField range:(NSRange)range shouldChangeString:(NSString *)string {
    if ([textField.accessibilityIdentifier isEqualToString:self.memoryAddress] == NO) {
        return YES;
    } else if (
                (range.length != 1 && [string isEqualToString:@""]) ||
                ([string isEqualToString:@""] &&
                 [string isKindOfClass:NSClassFromString(@"__NSCFString")] &&
                 ![string isKindOfClass:NSClassFromString(@"__NSCFConstantString")]
                )
              ) {
        return NO;// 屏蔽iPad上的撤销输入功能(可以撤销删除)
    } else if (range.length == 1 && [string isEqualToString:@""]) {
        return YES;// 删除
    } else if (self.matchRegular){
        return [string matchRegularExpressionWithFormat:self.matchRegular];
    }
    
    
    // 过滤特殊字符
   // NSCharacterSet * doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"'\"\\&+⛑⛸☘☄✨⛈⛷☃☂⛴⛰⛩⌨⏰⏲⏱⏳⚖⛏⚒⚙⛓☠⚔⚰⚱⚗⛱⛎✡☯☦☸☪✝☮❣❌⚛☢☣➿❎✅⚜❔❓❕✊⏸⏯⏹⏺⏭⏮⏩⏪⏫⏬〰➰➗➖➕©®™"];
    //NSString * tempString = [[string componentsSeparatedByCharactersInSet:doNotWant]componentsJoinedByString:@""];
    //BOOL ret = [string isEqualToString:tempString];
    return YES;
}



- (void)textFieldDidChangeText:(NSNotification *)notification{
    // 限制输入文字的长度，兼容表情和拼音，http://www.jianshu.com/p/2d1c06f2dfa4
    UITextField *textField = (UITextField *)notification.object;
    if ([textField.accessibilityIdentifier isEqualToString:self.memoryAddress]) {
        
        // 过滤掉Emoji
//        if ([textField.text hasEmoji]) {
//            textField.text = [textField.text removedEmojiString];
//        }
        
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制(8个字)
        if (!position){
            
            // 长度
            NSInteger maxLenght = 20;
            if (self.maximumLength) {
                maxLenght = self.maximumLength;
            }
            
            if (toBeString.length > maxLenght){
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxLenght];
                if (rangeIndex.length == 1){
                    textField.text = [toBeString substringToIndex:maxLenght];
                } else {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxLenght)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
        
        // 代理方法
        if ([self.delegate respondsToSelector:@selector(jk_textFieldDidChange:)]) {
            [self.delegate jk_textFieldDidChange:textField];
        }
    }
}

- (void)jk_trimmingCharactersForTextField:(UITextField *)textField{
    textField.text = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
