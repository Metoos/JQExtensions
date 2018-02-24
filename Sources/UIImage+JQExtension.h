//
//  UIImage+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

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


@end
