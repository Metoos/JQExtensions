//
//  UIImage+JQExtension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/11.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIImage+JQExtension.h"
#import <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>
#import <float.h>
@implementation UIImage (JQExtension)


/**
 *  加载存在根目录下的图片（以路径的形式）此方法不适用于加载Images.xcassets中的资源
 */
+ (instancetype)jq_imageWithName:(NSString *)name
{
    //    NSBundle *bundle = [NSBundle mainBundle];
    //
    ////    if ([UIScreen mainScreen].bounds.size.width>750) {
    ////        [name stringByAppendingString:@"@3x"];
    ////    }else
    ////    {
    ////        [name stringByAppendingString:@"@2x"];
    ////    }
    //
    //    NSString *path = [bundle pathForResource:name ofType:@"png"];
    //
    //    UIImage *image = [UIImage imageWithContentsOfFile:path];
    //
    //    return image;
    
    NSString *extension = @"png";
    
    NSArray *components = [name componentsSeparatedByString:@"."];
    if ([components count] >= 2) {
        NSUInteger lastIndex = components.count - 1;
        extension = [components objectAtIndex:lastIndex];
        
        name = [name substringToIndex:(name.length-(extension.length+1))];
    }
    
    // 如果为Retina屏幕且存在对应图片，则返回Retina图片，否则查找普通图片
    NSBundle *bundle = [NSBundle mainBundle];
    if ([UIScreen mainScreen].scale == 2.0) {
        name = [name stringByAppendingString:@"@2x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    if ([UIScreen mainScreen].scale == 3.0) {
        name = [name stringByAppendingString:@"@3x"];
        
        NSString *path = [bundle pathForResource:name ofType:extension];
        if (path != nil) {
            return [UIImage imageWithContentsOfFile:path];
        }
    }
    
    NSString *path = [bundle pathForResource:name ofType:extension];
    if (path) {
        return [UIImage imageWithContentsOfFile:path];
    }
    
    return nil;
}

+ (instancetype)animatedGIFNamed:(NSString *)name {
//    CGFloat scale = [UIScreen mainScreen].scale;

//    if (scale > 1.0f) {
//        NSString *retinaPath = [[NSBundle mainBundle] pathForResource:[name stringByAppendingString:@"@2x"] ofType:@"gif"];
//
//        NSData *data = [NSData dataWithContentsOfFile:retinaPath];
//
//        if (data) {
//            return [UIImage animatedGIFWithData:data];
//        }
//
//        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
//
//        data = [NSData dataWithContentsOfFile:path];
//
//        if (data) {
//            return [UIImage animatedGIFWithData:data];
//        }
//
//        return [UIImage imageNamed:name];
//    }
//    else {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        
        NSData *data = [NSData dataWithContentsOfFile:path];
        
        if (data) {
            return [UIImage animatedGIFWithData:data];
        }
        
        return [UIImage imageNamed:name];
//    }
}

+ (UIImage *)animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }

    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);

    size_t count = CGImageSourceGetCount(source);

    UIImage *animatedImage;

    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self frameDurationAtIndex:i source:source]/1.5;
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
            
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        //        NSLog(@"duration = %lf",duration);
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }

    CFRelease(source);

    return animatedImage;
    }

    + (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];

    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }

    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.

    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }

    CFRelease(cfFrameProperties);
    return frameDuration;
}

/**
 *截取当前视图
 **/
+ (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  将UIColor变换为UIImage
 */
+ (instancetype)jq_imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);

    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return theImage;
}



/**
 *  将UIColor变换为UIImage
 */
+ (instancetype)jq_imageWithColor:(UIColor *)color width:(CGFloat)width height:(CGFloat)height{

    CGRect rect = CGRectMake(0.0f, 0.0f, width, height);

    UIGraphicsBeginImageContext(rect.size);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);

    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return theImage;
}


/**
 *  按比例来压缩,固定宽度，高度自动缩放
 */
+ (instancetype) compressAndProportionWithImageName:(UIImage *)sourceImage AndWidth:(CGFloat)defineWidth{
//    CGFloat defineWidth = 800;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;

    [sourceImage drawInRect:thumbnailRect];

    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }

    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
    
}

/**
 *  返回一张自由拉伸的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name
{
    return [self resizedImageWithName:name left:0.5 top:0.5];
}

/**
 *  返回一张自由拉伸的图片
 */
+ (instancetype)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage jq_imageWithName:name];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
/**
 *  返回一张自由设置尺寸的图片
 */
+ (instancetype)resizedImage:(UIImage*)image toSize:(CGSize)size
{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
//    UIGraphicsBeginImageContext(CGSizeMake(size.width, size.height));
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

// 返回圆形图片
- (UIImage *)circleImage
{
    // NO代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 1);
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    // 方形变圆形
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (BOOL)hasAlpha
{
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(self.CGImage);
    return (alphaInfo == kCGImageAlphaFirst || alphaInfo == kCGImageAlphaLast ||
            alphaInfo == kCGImageAlphaPremultipliedFirst || alphaInfo == kCGImageAlphaPremultipliedLast);
}
/**
 *  裁剪图片
 */
- (UIImage *)croppedImageWithFrame:(CGRect)frame
{
    UIImage *croppedImage = nil;
    UIGraphicsBeginImageContextWithOptions(frame.size, ![self hasAlpha], self.scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextTranslateCTM(context, -frame.origin.x, -frame.origin.y);
        [self drawAtPoint:CGPointZero];
        
        croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    }
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithCGImage:croppedImage.CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
}

/**
 *  给UIImage 添加一个蒙版
 */
+ (UIImage*) maskImage:(UIImage *)image alpha:(CGFloat)alpha
{
    return [self maskImage:image withMask:[self jq_imageWithColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:alpha]]];
}
/**
 *  给UIImage 添加一个蒙版 自定义蒙版图片
 */
+ (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {

    //    CGImageRef maskRef = maskImage.CGImage;
    //
    //    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
    //                                        CGImageGetHeight(maskRef),
    //                                        CGImageGetBitsPerComponent(maskRef),
    //                                        CGImageGetBitsPerPixel(maskRef),
    //                                        CGImageGetBytesPerRow(maskRef),
    //                                        CGImageGetDataProvider(maskRef), NULL, false);
    //
    //
    //    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    //    CGImageRelease(mask);
    //    UIImage *maskedImage = [UIImage imageWithCGImage:masked ];
    //    CGImageRelease(masked);
    //    return maskedImage;
    CGImageRef maskRef = maskImage.CGImage;

    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        
                                        CGImageGetHeight(maskRef),
                                        
                                        CGImageGetBitsPerComponent(maskRef),
                                        
                                        CGImageGetBitsPerPixel(maskRef),
                                        
                                        CGImageGetBytesPerRow(maskRef),
                                        
                                        CGImageGetDataProvider(maskRef), NULL, false);



    CGImageRef sourceImage = [image CGImage];

    CGImageRef imageWithAlpha = sourceImage;

    //add alpha channel for images that don't have one (ie GIF, JPEG, etc...)

    //this however has a computational cost

    if (CGImageGetAlphaInfo(sourceImage) == kCGImageAlphaNone)

    {
        
        imageWithAlpha = [self CopyImageAndAddAlphaChannel:sourceImage];
        
    }



    CGImageRef masked = CGImageCreateWithMask(imageWithAlpha, mask);

    CGImageRelease(mask);



    //release imageWithAlpha if it was created by CopyImageAndAddAlphaChannel

    if (sourceImage != imageWithAlpha)

    {
        
        CGImageRelease(imageWithAlpha);
        
    }



    UIImage* retImage = [UIImage imageWithCGImage:masked];

    CGImageRelease(masked);



    return retImage;
}


+ (CGImageRef)CopyImageAndAddAlphaChannel:(CGImageRef)sourceImage

{
    
    CGImageRef retVal = NULL;
    
    
    
    size_t width = CGImageGetWidth(sourceImage);
    
    size_t height = CGImageGetHeight(sourceImage);
    
    
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    
    
    CGContextRef offscreenContext = CGBitmapContextCreate(NULL, width, height,
                                                          
                                                          8, 0, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    
    
    if (offscreenContext != NULL)
    
    {
        
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, width, height), sourceImage);
        
        retVal = CGBitmapContextCreateImage(offscreenContext);
        
        CGContextRelease(offscreenContext);
        
    }
    
    
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    return retVal;
    
}

/**
 *  返回一张圆角的图片
 */
- (UIImage*)imageWithCornerRadius:(CGFloat)radius
{

    CGRect rect = (CGRect){0.f,0.f,self.size};

    // void UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale);
    //size——同UIGraphicsBeginImageContext,参数size为新创建的位图上下文的大小
    //    opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
    //    scale—–缩放因子
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [UIScreen mainScreen].scale);

    //根据矩形画带圆角的曲线
    CGContextAddPath(UIGraphicsGetCurrentContext(), [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius].CGPath);

    [self drawInRect:rect];

    //图片缩放，是非线程安全的
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();

    //关闭上下文
    UIGraphicsEndImageContext();

    return image;
    
}

/**
 *  返回一张同心圆的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  返回一张变暗的图片
 */
- (UIImage *)darkenImageWithAlpha:(CGFloat)alpha
{
    
    UIImage *brighterImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIGaussianBlur"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    [lighten setValue:@(0.8) forKey:@"inputRadius"];
    
    CIImage *result = [lighten valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return brighterImage;
    
}

/**
 *  设置图片拉伸模式 默认四角拉伸
 */
+ (UIImage *)resizableImageWithImageNamed:(NSString*)imageNamed
{
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageNamed];
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    
    return [self resizableImageWithCapInsets:edgeInsets imageNamed:imageNamed];
}

/**
 *  设置图片拉伸模式
 */
+ (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)edgeInsets imageNamed:(NSString*)imageNamed
{
    // 加载图片
    UIImage *image = [UIImage imageNamed:imageNamed];
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    
    return newImage;
}



@end
