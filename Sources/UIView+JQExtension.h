//
//  UIView+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/27.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JQExtension)


@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGPoint origin;

/**xib或storyboard 快捷设置 layer 属性  */
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable BOOL    masksToBounds;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;
/**xib或storyboard 快捷设置 view上左上右圆角 与下面属性二者同时设置则无效*/
@property (nonatomic, assign) IBInspectable CGFloat topCorner;
/**xib或storyboard 快捷设置 view下左下右圆角  与上面属性二者同时设置则无效*/
@property (nonatomic, assign) IBInspectable CGFloat bottomCorner;



//找到自己当前所在的的viewController
- (UIViewController *)jq_viewController;

/** 按类名查找子视图  */
- (UIView*)subViewOfClassName:(NSString*)className;

/*
 周边加阴影，并且同时圆角
 */
- (void)shadowWithOpacity:(float)shadowOpacity
             shadowRadius:(CGFloat)shadowRadius
             shadowOffset:(CGSize)shadowOffset
              shadowColor:(UIColor*)shadowColor
          andCornerRadius:(CGFloat)cornerRadius;

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
