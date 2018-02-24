//
//  UIImageView+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/19.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h" //SDWebImage
#import "UIImage+JQExtension.h"
@interface UIImageView (JQExtension)

- (void)jq_setImageWithURL:(NSString *)url;

    
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;
    
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage options:(SDWebImageOptions)options;

//展示图片并更新缓存
- (void)jq_setImageAndUpdataCacheWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;
    
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage  completed:(void(^)(UIImage *image))completed;
    // 返回圆角图片
- (void)jq_setCircleImageWithURL:(NSString *)url CornerRadius:(CGFloat)cornerRadius placeholderImage:(UIImage *)placeholderImage;
    // 返回圆形图片
- (void)jq_setCircleImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;
/** 清除某条图片缓存 */
- (void)jq_clearImageCacheForKey:(NSString *)key;

    // 返回自由设置尺寸的网络图片
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage size:(CGSize)size;
// 返回固定宽 高按图片宽高比自动缩放 设置尺寸的网络图片
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage width:(CGFloat)width;
/** 返回一张压缩一半大小的图片 */
- (void)jq_setImageWithURL:(NSString *)url placeholderImage:(UIImage*)placeholderImage compression:(BOOL)isCompression;

- (void)setLayerRoundedCornersSize:(CGFloat)cornersSize;
    //防止直接使用layer设置圆角 触发离屏渲染 的图片圆角设置
    
    /** 使用CAShapeLayer和UIBezierPath设置圆角  */
- (void) setShapeRoundedCornersSize:(CGFloat)cornersSize;
    /** 通过layer和bezierPath 设置圆角 */
- (void)setLayerAndBezierPathCutCircularWithRoundedCornersSize:(CGFloat )cornersSize;
    /**  通过Graphics 和 BezierPath 设置圆角 */
- (void)setGraphicsCutCirculayWithRoundedCornersSize:(CGFloat )cornersSize;


@end
