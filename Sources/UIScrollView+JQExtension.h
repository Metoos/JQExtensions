//
//  UIScrollView+JQExtension.h
//  JQExtensionsDemo
//
//  Created by life on 2020/5/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapTipsViewRefreshBlock)(void);

@interface UIScrollView (JQExtension)

@property (strong, nonatomic) UIView *emptyView;
@property (strong, nonatomic) UIImageView *tipsImgView;
@property (strong, nonatomic) UILabel *titleLabel;
/**
 *空数据时点击界面任意地方回调 可用来做刷新数据触发
 */
@property (copy, nonatomic) TapTipsViewRefreshBlock tapRefreshBlock;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param imageNamed 图片资源名
 */
- (void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount
                              imageNamed:(NSString*)imageNamed;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param imageNamed 图片资源名
 * @Param title      提示标题
 */
- (void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount
                             imageNamed:(NSString *)imageNamed
                              tipsTitle:(NSString*)title;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param imageNamed 图片资源名
 * @Param title      提示标题
 * @Param color      标题颜色
 * @Param font       标题字体
 */
- (void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount
                             imageNamed:(NSString *)imageNamed
                              tipsTitle:(NSString*)title
                     withTipsTitleColor:(UIColor*)color
                      withTipsTitleFont:(UIFont*)font;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param rect       界面显示frame
 * @Param imageNamed 图片资源名
 * @Param title      提示标题
 * @Param color      标题颜色
 * @Param font       标题字体
 */
- (void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount
                               andFrame:(CGRect)rect
                             imageNamed:(NSString *)imageNamed
                              tipsTitle:(NSString*)title
                     withTipsTitleColor:(UIColor*)color
                      withTipsTitleFont:(UIFont*)font;

/** 移除空数据提示界面 */
- (void)dismessEmptyDataTipsView;


@end

