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

/** Unicode转UTF8中文
 *  @return 转换之后的UTF8字符串
 */
+ (NSString *)unicodeToUTF8:(NSString *)unicodeStr;
/** 中文转Unicode
 *  @return 转换之后的Unicode字符串
 */
+ (NSString *)utf8ToUnicode:(NSString *)string;

/**
 *  处理null
 *
 *  @return 处理之后的字符串
 */
+ (NSString *)content:(NSString *)string;

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
+ (BOOL)isEmptyString:(NSString*)string;

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
- (NSString *)sha1_base64;



- (CGSize)sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;


/****************** 系统信息模块 ******************/

/** 获取当前网络类型 */
+ (NSString *)getNetConnectType;

/** 获取iPhone名称 */
//返回 ‘某某’的iPhone
+ (NSString *)getiPhoneName;

/** 获取app版本号 */
+ (NSString *)getAPPVerion;

/** 当前系统名称 */
+ (NSString *)getSystemName;

/** 当前系统版本号 */
+ (NSString *)getSystemVersion;

/** 获取当前语言 */
+ (NSString *)getDeviceLanguage;

/**
 *获取设备UUID
 * 应用卸载后重新安装会改变
 **/
+ (NSString *)getUUID;

/** 获取设备名称 */
+ (NSString *)getDeviceName;

/** 获取平台号 */
+ (NSString *)getDevicePlatform;

/** 获取电池电量(这个方法获取电池电量不是很精确) */
+ (CGFloat)getBatteryLevel;

/** 获取精准电池电量 (通过 runtime 获取电池电量控件类私有变量的值，较为精确。)*/
+ (CGFloat)getCurrentBatteryLevel;

/** 获取电池当前的状态，共有4种状态 */
+ (NSString *) getBatteryState;

/**  获取总内存大小 */
+ (long long)getTotalMemorySize;

/** 获取当前可用内存 */
+ (long long)getAvailableMemorySize;

/** 已使用的内存空间 */
- (int64_t)getUsedMemory;

/** 获取设备mac 地址 */
- (NSString *)getMacAddress;

/** 获取设备IP地址 */
- (NSString *)getDeviceIPAddresses;

/**=============== CPU ==============*/

/** CPU 架构类型 */
+ (NSString *)getCPUType;

/** CPU总数目 */
- (NSUInteger)getCPUCount;

/** 已使用的CPU比例 */
- (float)getCPUUsage;

/** 获取每个cpu的使用比例 */
- (NSArray *)getPerCPUUsage;

/** ========= Disk磁盘空间 ========== */
/** 获取磁盘总空间 */
- (int64_t)getTotalDiskSpace;

/** 获取未使用的磁盘空间 */
- (int64_t)getFreeDiskSpace;

/** 获取已使用的磁盘空间 */
- (int64_t)getUsedDiskSpace;


@end
