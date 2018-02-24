//
//  UIImageView+JQExtension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/19.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIImageView+JQExtension.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImageView (JQExtension)
    
- (void)jq_setImageWithURL:(NSString *)url;
{
    
    [self jq_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed];
}

- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage*)placeholderImage compression:(BOOL)isCompression
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    [[SDImageCache sharedImageCache] clearMemory];
    __weak __typeof(&*self)weakSelf = self;
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGFloat originalWidth = image.size.width;
            CGFloat originalHeight = image.size.height;
            CGSize size =  CGSizeMake(originalWidth, originalHeight);
            if (isCompression) {
                size = CGSizeMake(originalWidth*0.5f, originalHeight*0.5f);
            }
            
            weakSelf.image = [UIImage resizedImage:image toSize:size];
        }
     
    }];
}
    
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    
    [self jq_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRetryFailed];
}

//展示图片并更新缓存
- (void)jq_setImageAndUpdataCacheWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    //清除图片缓存
    [[SDImageCache sharedImageCache] removeImageForKey:url];
//    //清除图片内存缓存防止内存占用过大
//    [[SDImageCache sharedImageCache] clearMemory];
    [self jq_setImageWithURL:url placeholderImage:placeholderImage options:SDWebImageRefreshCached];
}
    
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage options:(SDWebImageOptions)options
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    //清除图片内存缓存防止内存占用过大
    [[SDImageCache sharedImageCache] clearMemory];
    //从沙盒中加载图片防止内存中图片清除后和新图加载前的空白
    UIImage *image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:url];
    if (image) {
        self.image = image;
    }
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage options:options];
    
    
}
    
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage  completed:(void(^)(UIImage *image))completed
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    [[SDImageCache sharedImageCache] clearMemory];
    __weak __typeof(&*self)weakSelf = self;
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            weakSelf.image = [image circleImage];
        }
        if (completed) {
            completed(image);
        }
    }];
}
    
    // 返回圆形图片
- (void)jq_setCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage
{
    
    [self jq_setCircleImageWithURL:url placeholderImage:placeholderImage completed:NULL];
}
    
    // 返回圆形图片
- (void)jq_setCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage  completed:(void(^)(UIImage *image))completed
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    
    [[SDImageCache sharedImageCache] clearMemory];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:url];
    if (image) {
        self.image = image;
    }
    __weak __typeof(&*self)weakSelf = self;
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            weakSelf.image = [image circleImage];
        }
        if (completed) {
            completed(image);
        }
        
    }];
}

- (void)jq_clearImageCacheForKey:(NSString *)key
{
    [[SDImageCache sharedImageCache] removeImageForKey:key fromDisk:YES];
}

// 返回自由设置尺寸的网络图片
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage size:(CGSize)size
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    
    [[SDImageCache sharedImageCache] clearMemory];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:url];
    if (image) {
        self.image = image;
    }
    __weak __typeof(&*self)weakSelf = self;
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        DLog(@"image = %@ \n imageURL = %@ \n error = %@",image,imageURL.description,error);
        weakSelf.image = [UIImage resizedImage:image toSize:size];
        
        
    }];
}

// 返回固定宽 高按图片宽高比自动缩放 设置尺寸的网络图片
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage width:(CGFloat)width
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    
    [[SDImageCache sharedImageCache] clearMemory];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:url];
    if (image) {
        self.image = image;
    }
    __weak __typeof(&*self)weakSelf = self;
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        //        DLog(@"image = %@ \n imageURL = %@ \n error = %@",image,imageURL.description,error);
        if (image) {
            CGFloat originalWidth = image.size.width;
            CGFloat originalHeight = image.size.height;
            CGSize size = CGSizeMake(width, width*originalHeight/originalWidth);  //固定宽 高按图片宽高比自动缩放
            weakSelf.image = [UIImage resizedImage:image toSize:size];
        }
    }];
}
    
    // 返回圆角图片
- (void)jq_setCircleImageWithURL:(NSString *)url CornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage *)placeholderImage
{
    
    [self jq_setCircleImageWithURL:url CornerRadius:cornerRadius placeholderImage:placeholderImage completed:NULL];
}
    
    // 返回圆角图片
- (void)jq_setCircleImageWithURL:(NSString *)url CornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage *)placeholderImage  completed:(void(^)(UIImage *image))completed
{
    NSURL *nsUrl = [NSURL URLWithString:url];
    
    [[SDImageCache sharedImageCache] clearMemory];
    UIImage *image = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:url];
    if (image) {
        self.image = image;
    }
    __weak __typeof(&*self)weakSelf = self;
    [self sd_setImageWithURL:nsUrl placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            weakSelf.image = [image imageWithCornerRadius:cornerRadius];
        }
        if (completed) {
            completed(image);
        }
        
    }];
    
}
    
    
    
- (void)setLayerRoundedCornersSize:(CGFloat)cornersSize
    {
        self.layer.masksToBounds = YES;
        // 设置圆角半径
        self.layer.cornerRadius = cornersSize;
    }
    
    /** 使用CAShapeLayer和UIBezierPath设置圆角  防止直接使用layer设置圆角 触发离屏渲染*/
- (void)setShapeRoundedCornersSize:(CGFloat)cornersSize
    {
        //    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
        //                                                        cornerRadius:cornersSize];
        //    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        //    maskLayer.frame = self.bounds;
        //    maskLayer.path = maskPath.CGPath;
        //    self.layer.mask = maskLayer;
        
        [self setLayerRoundedCornersSize:cornersSize];
    }
    
#pragma mark - 通过layer和bezierPath 设置圆角
- (void)setLayerAndBezierPathCutCircularWithRoundedCornersSize:(CGFloat )cornersSize
    {
        //    // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
        //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornersSize, cornersSize)];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornersSize, cornersSize)];
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        layer.frame = self.bounds;
        layer.path = path.CGPath;
        self.layer.mask = layer;
    }
    
#pragma mark - 通过Graphics 和 BezierPath 设置圆角
- (void)setGraphicsCutCirculayWithRoundedCornersSize:(CGFloat )cornersSize
    {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 1.0);
        [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornersSize] addClip];
        [self drawRect:self.bounds];
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        // 结束
        UIGraphicsEndImageContext();
    }
    
    
@end

