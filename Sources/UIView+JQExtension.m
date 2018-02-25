//
//  UIView+JQExtension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/27.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIView+JQExtension.h"

@implementation UIView (JQExtension)



- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)top {
    return self.frame.origin.y;
}


- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)left {
    return self.frame.origin.x;
}


- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (UIViewController *)jq_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/** 使用CAShapeLayer和UIBezierPath设置圆角  防止直接使用layer设置圆角 触发离屏渲染*/
- (void)setShapeRoundedCornersSize:(CGFloat)cornersSize
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                        cornerRadius:cornersSize];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}



#pragma mark - 通过layer和bezierPath 设置左上右上圆角
-(void)setLayerAndBezierPathCutTopLeftWithTopRightCircularWithRoundedCornersSize:(CGFloat )cornersSize
{
    //    // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

#pragma mark - 通过layer和bezierPath 设置左下右下圆角
- (void)setLayerAndBezierPathCutBottomLeftWithBottomRightCircularWithRoundedCornersSize:(CGFloat )cornersSize
{
    //    // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}

#pragma mark - 通过layer和bezierPath 自定义设置上下左右圆角
- (void)setLayerAndBezierPathCustomCircularWithRoundedCornersSize:(CGFloat )cornersSize byRoundingCorners:(UIRectCorner)corners
{
    //    // 创建BezierPath 并设置角 和 半径 这里只设置了 左上 和 右上
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    
    //    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornersSize, cornersSize)];
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}


/** 设置view外边框*/
- (void)setborder
{
    [self setborderWidth:1.0 borderColor:[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1]];
}
/** 设置view外边框*/
- (void)setborderWidth:(CGFloat)borderWidth borderColor:(UIColor*)color
{
    self.layer.masksToBounds =  YES;
    self.layer.borderWidth = borderWidth;
    self.layer.borderColor = color.CGColor;
}

- (void) setLayerRoundedCornersSize:(CGFloat)cornersSize
{
    self.layer.masksToBounds =  YES;
    self.layer.cornerRadius = cornersSize;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    //    self.layer.rasterizationScale = 1.0;
}
#pragma mark - 给UIView开始添加轻拍方法
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)sel
{
    /** 给试图添加点击方法 */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:sel];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

#pragma mark - 视图显示和隐藏泡泡动画
- (void)showViewPapawAnimation:(BOOL)isShow
{
    
    if (isShow) {
        self.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
        self.hidden = !isShow;
        [UIView animateWithDuration:0.3f
                              delay:0.1f
             usingSpringWithDamping:0.5f
              initialSpringVelocity:0.2f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         } completion:^(BOOL finished) {
                             
                         }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeScale(0.0f, 0.0f);
        } completion:^(BOOL finished) {
            self.hidden = !isShow;
        }];
    }
    
}


@end
