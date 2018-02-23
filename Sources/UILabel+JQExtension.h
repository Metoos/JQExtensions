//
//  UILabel+JQExtension.h
//  DuoMiPay
//
//  Created by life on 2017/12/26.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (JQExtension)


/**
 *  改变行间距
 *  @param space 间距值
 */
- (void)changeLineWithSpace:(CGFloat)space;

/**
 *  改变字间距
 *  @param space 间距值
 */
- (void)changeWordWithSpace:(CGFloat)space;

/**
 *  改变行间距和字间距
 *  @param lineSpace 行间距值
 *  @param lineSpace 字间距值
 */
- (void)changeSpaceWithLineSpace:(CGFloat)lineSpace WordSpace:(CGFloat)wordSpace;


@end
