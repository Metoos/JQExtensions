//
//  UITableView+JQExtension.h
//  DuoMiPay
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JQExtension)

@property (strong, nonatomic) UIView *emptyView;
@property (strong, nonatomic) UIImageView *tipsImgView;
@property (strong, nonatomic) UILabel *titleLabel;
/**  
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param imageNamed 图片资源名 
 */
- (void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount imageNamed:(NSString*)imageNamed;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param imageNamed 图片资源名
 * @Param title      提示标题
 */
-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount imageNamed:(NSString *)imageNamed tipsTitle:(NSString*)title;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param imageNamed 图片资源名
 * @Param title      提示标题
 * @Param color      标题颜色
 * @Param font       标题字体
 */
-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount imageNamed:(NSString *)imageNamed tipsTitle:(NSString*)title withTipsTitleColor:(UIColor*)color  withTipsTitleFont:(UIFont*)font;

/**
 * 显示空数据提示界面
 * @Param rowCount   数据源条数
 * @Param rect       界面显示frame
 * @Param imageNamed 图片资源名
 * @Param title      提示标题
 * @Param color      标题颜色
 * @Param font       标题字体
 */
-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount andFrame:(CGRect)rect imageNamed:(NSString *)imageNamed tipsTitle:(NSString*)title withTipsTitleColor:(UIColor*)color  withTipsTitleFont:(UIFont*)font;

/** 移除空数据提示界面 */
- (void)dismessEmptyDataTipsView;

@end
