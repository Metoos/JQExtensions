//
//  UIButton+JQExtension.h
//  DuoMiPay
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JQButtonIndefiniteAnimatedView.h"
@interface UIButton (JQExtension)

/** 快速设置普通状态标题 */
- (void)setTitle:(NSString *)title;
/** 快速设置普通状态标题颜色 */
- (void)setTitleColor:(UIColor *)color;
/** 快速设置普通状态标题字体 */
- (void)setTitleFont:(UIFont *)font;
/** 快速设置普通状态图片 */
- (void)setImage:(UIImage *)image;


@property (nonatomic)JQButtonIndefiniteAnimatedView *indefiniteAnimatedView;

/** 设置按钮为 上图片下文字的显示方式 图文间隙默认为 10*/
- (void)setTopImageWithBottomTitleConentMode;
/** 设置按钮为 上图片下文字的显示方式  space图文间隙*/
-(void)setTopImageWithBottomTitleConentModeWithSpace:(CGFloat)space;

/** 设置按钮为 右图片左文字的显示方式 图文间隙默认为 10*/
- (void)setConentModeRightImage:(UIImage*)image leftTitle:(NSString*)title;
/** 设置按钮为 右图片左文字的显示方式 space图文间隙*/
- (void)setConentModeRightImage:(UIImage*)image leftTitle:(NSString*)title space:(CGFloat)space;



/** 添加按钮加载中状态
 * @param title 标题
 */
- (void)setLoadingWithTitle:(NSString *)title;

/** 添加按钮加载中状态
 * @param title 标题
 * @param radius 半径（加载圈圈半径）
 */
- (void)setLoadingWithTitle:(NSString *)title radius:(NSInteger)radius;

/** 移除按钮加载中状态
 * @param title 标题
 */
- (void)setNormalWithTitle:(NSString *)title;

/** 按钮不可点击状态
 * @param title 标题
 */
- (void)setUnabledWithTitle:(NSString *)title;

@end

