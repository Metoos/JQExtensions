//
//  UIView+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/27.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JQExtension)

//@property (nonatomic) CGFloat jq_left;
//
///**
// * Shortcut for frame.origin.y
// *
// * Sets frame.origin.y = top
// */
//@property (nonatomic) CGFloat jq_top;
//
///**
// * Shortcut for frame.origin.x + frame.size.width
// *
// * Sets frame.origin.x = right - frame.size.width
// */
//@property (nonatomic) CGFloat jq_right;
//
///**
// * Shortcut for frame.origin.y + frame.size.height
// *
// * Sets frame.origin.y = bottom - frame.size.height
// */
//@property (nonatomic) CGFloat jq_bottom;
//
///**
// * Shortcut for frame.size.width
// *
// * Sets frame.size.width = width
// */
//@property (nonatomic) CGFloat jq_width;
//
///**
// * Shortcut for frame.size.height
// *
// * Sets frame.size.height = height
// */
//@property (nonatomic) CGFloat jq_height;
//
///**
// * Shortcut for center.x
// *
// * Sets center.x = centerX
// */
//@property (nonatomic) CGFloat jq_centerX;
//
///**
// * Shortcut for center.y
// *
// * Sets center.y = centerY
// */
//@property (nonatomic) CGFloat jq_centerY;
///**
// * Shortcut for frame.origin
// */
//@property (nonatomic) CGPoint jq_origin;
//
///**
// * Shortcut for frame.size
// */
//@property (nonatomic) CGSize jq_size;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGPoint origin;

//找到自己的vc
- (UIViewController *)jq_viewController;


/** 使用CAShapeLayer和UIBezierPath设置圆角  */
- (void) setShapeRoundedCornersSize:(CGFloat)cornersSize;

/** Layer设置圆角  */
- (void) setLayerRoundedCornersSize:(CGFloat)cornersSize;

/** 通过layer和bezierPath 设置左上右上圆角 */
- (void)setLayerAndBezierPathCutTopLeftWithTopRightCircularWithRoundedCornersSize:(CGFloat )cornersSize;

/** 通过layer和bezierPath 设置左下右下圆角 */
- (void)setLayerAndBezierPathCutBottomLeftWithBottomRightCircularWithRoundedCornersSize:(CGFloat )cornersSize;

/**  通过layer和bezierPath 自定义设置上下左右圆角 */
- (void)setLayerAndBezierPathCustomCircularWithRoundedCornersSize:(CGFloat )cornersSize byRoundingCorners:(UIRectCorner)corners;

/** 设置view外边框 使用默认值*/
- (void)setborder;
/** 设置view外边框 使用自定义值 */
- (void)setborderWidth:(CGFloat)borderWidth borderColor:(UIColor*)color;

//给UIView开始添加轻拍方法
- (void)addTapGestureRecognizerWithTarget:(id)target action:(SEL)sel;

/** 视图显示和隐藏泡泡动画 */
- (void)showViewPapawAnimation:(BOOL)hidden;



@end
