//
//  NSString+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (JQExtension)
/**
 *  处理null
 *
 *  @return 处理之后的字符串
 */
- (NSString *)content;

/**
 * 手机号码格式验证
 * @return YES OR NO
 */
- (BOOL)isCheckTel;

/**
 * 邮箱格式验证
 * @return YES OR NO
 */

-(BOOL)isValidateEmail;

/**
 * 身份证号格式验证
 * @return YES OR NO
 */
- (BOOL) isValidateIdentityCard;


/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  返回沙盒中的文件路径
 *
 *  @return 返回当前字符串对应在沙盒中的完整文件路径
 */
- (NSString *)documentsPath;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;

/**
 *  根据文本返回size
 */
- (CGSize)boundingRectWithSize:(CGSize)size attributes:(NSDictionary *)dic;


/**
 *  md5编码
 */
- (NSString *)md5;

/**
 *  URLEncode
 */
+(NSString*)encodeString:(NSString*)unencodedString;


/**
 *  urlencoding的解码
 */
-(NSString *)decodeString:(NSString*)encodedString;

/**
 *  sha1加密方式
 */
- (NSString *)Sha1;


/**
 *  sha1_base64加密
 */
- (NSString *) sha1_base64;



- (CGSize)sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;



@end
