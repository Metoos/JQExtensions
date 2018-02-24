//
//  UIView+JQFontSize.h
//  FontSizeModify
//
//  Created by dyw on 16/10/22.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JQUITextViewEnable 1
#define JQUITextFieldEnable 1
#define JQUIButtonEnable 1
#define JQUILabelEnable 1

@interface UIView (JQFontSize)

/**
 设置需要忽略的空间tag值

 @param tagArr tag值数组
 */
+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr;

/**
 设置字体大小比例

 @param value 需要设置的比例
 */
+ (void)setFontScale:(CGFloat)value;

@end

