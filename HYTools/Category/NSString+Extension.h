//
//  NSString+Extension.h
//  微博
//
//  Created by 崔宇轩 on 15/8/2.
//  Copyright (c) 2015年 崔宇轩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)
/**    正则表达式匹配通用方法    */
- (BOOL)matchRegularExpressionWithFormat:(NSString *)match;


@property (nonatomic, strong, readonly) NSURL *URL;

@property (nonatomic, copy, readonly) NSString *MD5Value;

@property (nonatomic, copy, readonly) NSString *base64String;




/** 字符串去掉前后空格 */
@property (nonatomic, copy, readonly) NSString *stringRemovedBlankPrefixAndSuffix;

- (BOOL)isValidNameWithRange:(NSRange)range;

NSString *IntegerTypeBundleShortVersionString(void);



/**
 返回一个00格式的日期字符串
 */
@property (nonatomic, copy, readonly) NSString *dateFormatString;

/**
 返回一个00格式的日期字符串
 */
+ (NSString *)dateFormatStringWithValue:(NSInteger)value;

/**
 根据文本和字体返回文本宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font;

/**
 根据文本、字体、约束范围，返回文本范围
 */
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
/**检查是否有表情符号*/
- (BOOL)hasEmoji;

/**
 根据format正则表达式规则判断字符串是否有效
 */
- (BOOL)isValidWithFormat:(NSString *)format;

/**身份证号是否合法*/
- (BOOL)isValidIDCode;

/**手机号是否合法*/
- (BOOL)isValidPhoneNumber;

/**    JP 判断某个字符是否是数字    */
- (BOOL)isValidNumber;

/**账号是不是纯数字*/
- (BOOL)isValidAccountNumber;


/**汉字，字母和数字*/
- (BOOL)isValidName;

/**    JP IM聊天专用(匹配全部为空格)    */
- (BOOL)im_isValidChatMessageString;

/**    JP 汉字、数字、英文    */
//- (BOOL)im_isValidNameString;

/**    JP 匹配表情    */
- (BOOL)im_hasEmoji;


/**    JP 过滤表情    */
- (instancetype)im_removedEmojiString;

/**    JP 网址    */
- (BOOL)isValidURL;

/**    JP 汉字的拼音    */
- (NSString *)pinyin;



/**    JP 当前的时间戳    */
+ (NSString *)timeIntervalStringSince1970;


/**    JP IM的文件缓存文件夹路径    */
+ (NSString *)IMCacheFolderWithName:(NSString *)folderName;


/**    JP 某个路径的文件大小    */
+ (long long)fileSizeAtFilePath:(NSString *)path;


/**    JP 字符串的长度    */
- (CGSize)sizeWithFont:(UIFont *)font andFitSize:(CGSize)size;
/**    JP 计算字符串的长度，段落样式    */
- (CGSize)sizeForParagraphStyleWithFont:(UIFont *)font andMaxWidth:(CGFloat)maxW;


/**   解析JSON string */
- (NSDictionary *)parseJSONStr;


/**
 dictionary转json string
 */
- (NSString *)convertToJsonData:(NSDictionary *)dict;


/**    JP 是否是当天    */
- (BOOL)isCurrentDay;

/**    JP 算聊天的时间日期    */
- (NSString *)dateStringForTimeIntel;

/**    JP 云聊界面的时间计算    */
- (NSString *)dateStringForChatHistory;

/**    JP iOS头像链接,原图    */
- (NSString *)originFaceUrlForIM;

/**    JP iOS头像链接,小图    */
- (NSString *)smallFaceUrlForIM;

/**    JP iOS头像链接,中图    */
- (NSString *)midFaceUrlForIM;

/**    JP 大图,不要缓存图片    */
- (NSString *)bigFaceUrlForIM;


/**    JP 字符串转BRG color  #ff21af64    */
- (UIColor *)RGBColor;


// 将阿拉伯数组转为汉字
NSString * NSMakeCNNumber(NSInteger number);

/**同 [NSString stringWithFormat:format, ...]*/
NSString *NSStringWithFormat(NSString *format, ...);

@end

