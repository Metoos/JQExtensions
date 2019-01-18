//
//  UIImage+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, GradientType) {
    GradientTypeTopToBottom = 0,//从上到小
    GradientTypeLeftToRight = 1,//从左到右
    GradientTypeUpleftToLowright = 2,//左上到右下
    GradientTypeUprightToLowleft = 3,//右上到左下
};

@interface UIImage (JQExtension)

    // 返回圆形图片
- (UIImage *)circleImage;
    
    /**
     *  加载显示播放gif
     */
    
+ (instancetype)animatedGIFNamed:(NSString *)name;
    /**
     *  按比例来压缩,固定宽度，高度自动缩放
     */
+ (instancetype) compressAndProportionWithImageName:(UIImage *)sourceImage AndWidth:(CGFloat)defineWidth;
    
    /**
     *  加载存在根目录下的图片（以路径的形式）此方法不适用于加载Images.xcassets中的资源
     */
+ (instancetype)jq_imageWithName:(NSString *)name;
    /**
     *截取当前视图
     **/
+ (UIImage *) captureScreen;
    /**
     *  将UIColor变换为UIImage
     */
+ (instancetype)jq_imageWithColor:(UIColor *)color;
    /**
     *  将UIColor变换为UIImage
     */
+ (instancetype)jq_imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height;

/**
 *  渐变颜色生成图片
 */
+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

/**
 *  返回一张自由拉伸的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name;
+ (instancetype)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
/**
 *  返回一张自由设置尺寸的图片
 */
+ (instancetype)resizedImage:(UIImage*)image toSize:(CGSize)size;

    /**
     *  返回一张圆角的图片
     */
- (UIImage*)imageWithCornerRadius:(CGFloat)radius;
    
    /**
     *  返回一张圆角的图片
     */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
    
    /**
     *  裁剪图片
     */
- (UIImage *)croppedImageWithFrame:(CGRect)frame;
    
    /**
     *  给UIImage 添加一个蒙版
     */
+ (UIImage*) maskImage:(UIImage *)image alpha:(CGFloat)alpha;
    /**
     *  给UIImage 添加一个蒙版 自定义蒙版图片
     */
    
+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
    
    /**
     *  返回一张变暗的图片
     */
- (UIImage *)darkenImageWithAlpha:(CGFloat)alpha;



/**
 *  设置图片拉伸模式 默认四角拉伸
 */
+ (UIImage *)resizableImageWithImageNamed:(NSString*)imageNamed;

/**
 *  设置图片拉伸模式
 */
+ (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)edgeInsets imageNamed:(NSString*)imageNamed;



/** 根据视频url获取第一帧图片*/
+ (UIImage *)videoPreViewImage:(NSURL *)path;

/** base64字符串转图片 */
+ (UIImage *)base64StrToUIImage:(NSString *)encodedImageStr;

/** 图片转base64字符串 */
+ (NSString *)imageToBase64Str:(UIImage *)image;

/**
 *  生成毛玻璃效果的图片
 *
 *  @param image      要模糊化的图片
 *  @param blurAmount 模糊化指数
 *
 *  @return 返回模糊化之后的图片
 */
+ (UIImage *)blurredImageWithImage:(UIImage *)image andBlurAmount:(CGFloat)blurAmount;

/**
 *  图形模糊算法
 *
 *  @param image     要模糊的图片
 *  @param blurLevel 模糊的级别
 *
 *  @return 模糊好的图片
 */
- (UIImage *)blearImageWithBlurLevel:(CGFloat)blurLevel;
/**
 对比两张图片是否相同
 
 @param image 原图
 @param anotherImage 需要比较的图片
 
 */
+ (BOOL)imageEqualToImage:(UIImage*)image anotherImage:(UIImage *)anotherImage;

/**
 图片透明度
 @param alpha 透明度
 @param image 原图
 
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

/**
 镶嵌图片
 
 @param firstImage 图片1
 @param secondImage 图片2
 @return 拼接后的图片
 */
+ (UIImage *)spliceFirstImage:(UIImage *)firstImage secondImage:(UIImage *)secondImage;

/**
 生成二维码图片
 
 @param dataDic 二维码中的信息
 @param size 二维码Size
 @param waterImage 水印图片
 @return 一个二维码图片，水印在二维码中央
 */
+ (UIImage *)qrCodeImageForDataString:(NSString *)dataStr size:(CGSize)size waterImage:(UIImage *)waterImage;

/**
 修改二维码颜色
 @param image 二维码图片
 @param red red
 @param green green
 @param blue blue
 @return 修改颜色后的二维码图片
 */
+ (UIImage *)changeColorWithQRCodeImage:(UIImage *)image red:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

@end
