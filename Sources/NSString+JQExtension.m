//
//  NSString+Extension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "NSString+JQExtension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (JQExtension)
#pragma mark 处理NULL值
- (NSString *)content {
    if ([self isEqual:[NSNull null]]) {
        return @"";
    }
    if (self.length > 0) {
        return self;
    } else {
        return @"";
    }
}


#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return (self == nil || self.length == 0);
}


#pragma mark -验证手机号码的正则表达式(只判断，无弹窗)
- (BOOL)isCheckTel
{
    if ([self length] == 0) {
        
        return NO;
    }
    //    NSString *regex = @"^((13[0-9])|(14[5,7])|(15[^4,\\D])|(17[0678,\\D])|(18[01,5-9]))\\d{8}$";
    NSString *regex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];    BOOL isMatch = [pred evaluateWithObject:self];
    if (!isMatch) {
        
        return NO;
    }
    return YES;
}


#pragma mark -邮箱验证
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark -身份证号验证
- (BOOL) isValidateIdentityCard
{
    
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}


#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingString:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -根据文本返回size
- (CGSize)boundingRectWithSize:(CGSize)size attributes:(NSDictionary *)dic {
    
    CGSize size1 = [self boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size1;
    
}


/**
 *  md5加密
 */
- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [[NSString alloc] initWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}



//URLEncode
+(NSString*)encodeString:(NSString*)unencodedString{
    
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}


//URLDEcode
-(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


#pragma mark -sha1_base64加密
- (NSString *) sha1_base64
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
     NSString *output = [base64 base64EncodedStringWithOptions:0];
//    NSString * output = [[NSString alloc] initWithData:base64 encoding:NSUTF8StringEncoding];
    
    
    return output;
}

//sha1加密方式
- (NSString *)Sha1{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}






- (CGFloat)widthWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    return [self sizeWithFont:font lineSpacing:0 constrainedToSize:size lineBreakMode:lineBreakMode].width;
}

- (CGFloat)widthWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    return [self sizeWithFont:font lineSpacing:lineSpacing constrainedToSize:size lineBreakMode:lineBreakMode].width;
}

- (CGFloat)heightWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    return [self sizeWithFont:font lineSpacing:0 constrainedToSize:size lineBreakMode:lineBreakMode].height;
}

- (CGFloat)heightWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    return [self sizeWithFont:font lineSpacing:lineSpacing constrainedToSize:size lineBreakMode:lineBreakMode].height;
}

- (CGSize)sizeWithFont:(UIFont *)font lineSpacing:(CGFloat)lineSpacing constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode {
    
    CGSize textSize;
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        //NSDictionary *attributes = @{NSFontAttributeName:font}
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        //textSize = [self sizeWithAttributes:attributes];
        //textSize = []
        
        textSize = [self sizeWithAttributes:attributes];
        
    } else {
        
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（字体大小+行间距=行高）
        
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        
        [attributes setValue:font forKey:NSFontAttributeName];
        
        if (lineSpacing) {
            
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            
            [paragraphStyle setLineSpacing:lineSpacing];
            
            [attributes setValue:paragraphStyle forKey:NSParagraphStyleAttributeName];
        }
        
        CGRect rect = [self boundingRectWithSize:size options:option attributes:attributes context:nil];
        
        textSize = rect.size;
    }
    
    return textSize;
}

@end
