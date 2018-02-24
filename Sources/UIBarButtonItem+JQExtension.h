//
//  UIBarButtonItem+JQExtension.h
//  JQExtensions
//
//  Created by zjq on 2017/6/27.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickBlock)(void);
@interface UIBarButtonItem (JQExtension)

@property (nonatomic)void(^ClickBlock)(void);

/** 
 *使用一张图片来创建一个UIBarButtonItem
 *@param imageNamed 图片资源名
 *@param click      点击回调block
 */
- (instancetype)initWithCustomViewWithImageNamed:(NSString*)imageNamed
                                           Click:(ClickBlock)click;
/**
 *使用字符串标题来创建一个UIBarButtonItem
 *@param title 标题
 *@param click 点击回调block
 */
- (instancetype)initWithTitle:(NSString *)title
                        Click:(ClickBlock)click;
/**
 *使用一张网络图片来创建一个UIBarButtonItem
 *@param imageUrl   图片网络地址
 *@param image      placeholder Image
 *@param click      点击回调block
 */
- (instancetype)initWithCustomViewWithImageUrl:(NSString*)imageUrl
                              placeholderImage:(UIImage*)image
                                         Click:(ClickBlock)click;
@end
