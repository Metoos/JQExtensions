//
//  UIButton+JQExtension.m
//  DuoMiPay
//
//  Created by mac on 2017/7/18.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIButton+JQExtension.h"
#import <objc/runtime.h>
static char K_IndefiniteAnimatedView;
@implementation UIButton (JQExtension)

/** 快速设置普通状态标题 */
- (void)setTitle:(NSString *)title
{
    [self setTitle:title forState:UIControlStateNormal];
}
/** 快速设置普通状态标题颜色 */
- (void)setTitleColor:(UIColor *)color
{
    [self setTitleColor:color forState:UIControlStateNormal];
}
/** 快速设置普通状态标题字体 */
- (void)setTitleFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

/** 快速设置普通状态图片 */
- (void)setImage:(UIImage *)image
{
    [self setImage:image forState:UIControlStateNormal];
}


/** 设置按钮为 上图片下文字的显示方式 图文间隙默认为 10*/
-(void)setTopImageWithBottomTitleConentMode
{
    [self setTopImageWithBottomTitleConentModeWithSpace:10.0f];
    
}
/** 设置按钮为 上图片下文字的显示方式  space图文间隙*/
-(void)setTopImageWithBottomTitleConentModeWithSpace:(CGFloat)space
{
    //    //使图片和文字水平居中显示
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
    //图片距离右边框距离减少图片的宽度，其它不边
    [self setImageEdgeInsets:UIEdgeInsetsMake(-((titleSize.height+space+self.imageView.frame.size.height)/2), 0.0, 0.0, -titleSize.width)];
    //文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
    [self setTitleEdgeInsets:UIEdgeInsetsMake(self.imageView.frame.size.height+self.imageView.frame.origin.y+space, -self.imageView.frame.size.width, 0.0, 0.0)];
}

/** 设置按钮为 右图片左文字的显示方式 图文间隙默认为 10*/
- (void)setConentModeRightImage:(UIImage*)image leftTitle:(NSString*)title
{
    [self setConentModeRightImage:image leftTitle:title space:10.0f];
}
/** 设置按钮为 右图片左文字的显示方式 space图文间隙*/
- (void)setConentModeRightImage:(UIImage*)image leftTitle:(NSString*)title space:(CGFloat)space
{
    
    CGFloat titleW = CGRectGetWidth(self.titleLabel.bounds);//titleLabel的宽度
    
    
    CGFloat imageW = CGRectGetWidth(self.imageView.bounds);//imageView的宽度
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageW + space/2), 0, imageW + space/2);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleW+space/2, 0, -(titleW+space/2));
    
    
}

- (void)setLoadingWithTitle:(NSString *)title
{
    [self setLoadingWithTitle:title radius:12];
}

- (void)setLoadingWithTitle:(NSString *)title radius:(NSInteger)radius
{
    if (self.enabled) {
        self.indefiniteAnimatedView = [[JQButtonIndefiniteAnimatedView alloc]init];
        self.indefiniteAnimatedView.strokeColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        self.indefiniteAnimatedView.strokeThickness = 2;
        self.indefiniteAnimatedView.radius = radius;
        [self.indefiniteAnimatedView sizeToFit];
        NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
        CGSize titleSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.titleLabel.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
        
        
        CGFloat x = self.frame.size.width/2 - titleSize.width/2 - radius*2-20;
        CGFloat y = self.frame.size.height/2 - self.indefiniteAnimatedView.frame.size.width/2;
        self.indefiniteAnimatedView.frame = CGRectMake(x, y,  self.indefiniteAnimatedView.frame.size.width, self.indefiniteAnimatedView.frame.size.height);
        [self addSubview:self.indefiniteAnimatedView];
        
        [self setTitle:title?:self.titleLabel.text forState:UIControlStateNormal];
        
        self.alpha = 0.6;
        self.enabled = NO;
        [self superview].userInteractionEnabled = NO;
    }
    
    
}

- (void)setNormalWithTitle:(NSString *)title
{
    [self.indefiniteAnimatedView removeFromSuperview];
    self.indefiniteAnimatedView = nil;
    self.alpha = 1;
    self.enabled = YES;
    [self setTitle:title?:self.titleLabel.text forState:UIControlStateNormal];
    
    [self superview].userInteractionEnabled = YES;
//    [[[UIApplication sharedApplication] delegate].window setUserInteractionEnabled:YES];
}

/** 按钮不可点击状态
 * @param title 标题
 */
- (void)setUnabledWithTitle:(NSString *)title
{
    [self.indefiniteAnimatedView removeFromSuperview];
    self.indefiniteAnimatedView = nil;
    self.alpha = 0.6;
    self.enabled = NO;
    [self setTitle:title?:self.titleLabel.text forState:UIControlStateNormal];
    
    [self superview].userInteractionEnabled = YES;
}

- (void)setIndefiniteAnimatedView:(JQButtonIndefiniteAnimatedView *)indefiniteAnimatedView
{
    objc_setAssociatedObject(self, &K_IndefiniteAnimatedView, indefiniteAnimatedView, OBJC_ASSOCIATION_RETAIN);
}

- (JQButtonIndefiniteAnimatedView *)indefiniteAnimatedView
{
    return objc_getAssociatedObject(self, &K_IndefiniteAnimatedView);
}

@end

