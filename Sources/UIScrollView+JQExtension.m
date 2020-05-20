//
//  UIScrollView+JQExtension.m
//  JQExtensionsDemo
//
//  Created by life on 2020/5/20.
//  Copyright © 2020 mac. All rights reserved.
//

#import "UIScrollView+JQExtension.h"
#import <objc/runtime.h>

static char EMPTYVIEWKEY;
static char TIPSIMAGEVIEWKEY;
static char TITLELABELKEY;
static char TAPREFRESHBLOCK;
@implementation UIScrollView (JQExtension)

- (UIView *)emptyView
{
    return objc_getAssociatedObject(self, &EMPTYVIEWKEY);
}
- (void)setEmptyView:(UIView *)emptyView
{
    if (emptyView != self.emptyView) {
        
        [self willChangeValueForKey:@"emptyView"]; // KVO
        objc_setAssociatedObject(self, &EMPTYVIEWKEY,
                                 emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"emptyView"]; // KVO
    }
}

- (TapTipsViewRefreshBlock)tapRefreshBlock
{
    return objc_getAssociatedObject(self, &TAPREFRESHBLOCK);
}

- (void)setTapRefreshBlock:(TapTipsViewRefreshBlock)tapRefreshBlock
{
    if (tapRefreshBlock != self.tapRefreshBlock) {
        
        [self willChangeValueForKey:@"tapRefreshBlock"]; // KVO
        objc_setAssociatedObject(self, &TAPREFRESHBLOCK,
                                 tapRefreshBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
        [self didChangeValueForKey:@"tapRefreshBlock"]; // KVO
    }
}


- (void)setTipsImgView:(UIImageView *)tipsImgView
{
    if (tipsImgView != self.tipsImgView) {
        
        [self willChangeValueForKey:@"tipsImgView"]; // KVO
        objc_setAssociatedObject(self, &TIPSIMAGEVIEWKEY,
                                 tipsImgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"tipsImgView"]; // KVO
    }
}
- (UIImageView *)tipsImgView
{
    return objc_getAssociatedObject(self, &TIPSIMAGEVIEWKEY);
}

-(void)setTitleLabel:(UILabel *)titleLabel
{
    if (titleLabel != self.titleLabel) {
        
        [self willChangeValueForKey:@"titleLabel"]; // KVO
        objc_setAssociatedObject(self, &TITLELABELKEY,
                                 titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"titleLabel"]; // KVO
    }
}

- (UILabel *)titleLabel
{
    return objc_getAssociatedObject(self, &TITLELABELKEY);
}

#pragma mark - 显示空数据提示界面
-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount imageNamed:(NSString *)imageNamed
{
    [self showEmptyDataTipsViewForRowCount:rowCount imageNamed:imageNamed tipsTitle:nil];
}

-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount imageNamed:(NSString *)imageNamed tipsTitle:(NSString *)title
{
    [self showEmptyDataTipsViewForRowCount:rowCount imageNamed:imageNamed tipsTitle:title withTipsTitleColor:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1] withTipsTitleFont:[UIFont systemFontOfSize:17]];
  
}

-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount imageNamed:(NSString *)imageNamed tipsTitle:(NSString*)title withTipsTitleColor:(UIColor*)color  withTipsTitleFont:(UIFont*)font
{
    [self showEmptyDataTipsViewForRowCount:rowCount andFrame:self.bounds imageNamed:imageNamed tipsTitle:title withTipsTitleColor:color withTipsTitleFont:font];
}

-(void)showEmptyDataTipsViewForRowCount:(NSInteger)rowCount andFrame:(CGRect)rect imageNamed:(NSString *)imageNamed tipsTitle:(NSString*)title withTipsTitleColor:(UIColor*)color  withTipsTitleFont:(UIFont*)font
{
    if (rowCount <= 0) {
        [self dismessEmptyDataTipsView];
        
        self.emptyView = [[UIView alloc]initWithFrame:rect];
        self.emptyView.backgroundColor = [UIColor clearColor];
        [[self superview] addSubview:self.emptyView];
        self.scrollEnabled = NO;//关闭tableView滚动功能
        //提示图片
        self.tipsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNamed]];
        self.tipsImgView.frame  = CGRectMake(0, 0, 160, 160);
        self.tipsImgView.contentMode = UIViewContentModeScaleAspectFit;
        self.tipsImgView.center = CGPointMake(self.emptyView.center.x, self.emptyView.center.y );
        
        [self.emptyView addSubview:self.tipsImgView];
        
        if (title) {
            self.tipsImgView.center = CGPointMake(self.emptyView.center.x, self.emptyView.center.y-38/2);
            CGFloat Y = self.tipsImgView.frame.origin.y + self.tipsImgView.frame.size.height+8;
            CGFloat W = self.frame.size.width - 20;
            self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, Y, W, 30)];
            self.titleLabel.text = title;
            self.titleLabel.font = font;
            self.titleLabel.textColor = color;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            [self.emptyView addSubview:self.titleLabel];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        self.emptyView.userInteractionEnabled = YES;
        [self.emptyView addGestureRecognizer:tap];
        
    }else
    {
        [self dismessEmptyDataTipsView];
    }
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    !self.tapRefreshBlock?:self.tapRefreshBlock();
    
}

#pragma mark - 移除空数据提示界面
- (void)dismessEmptyDataTipsView
{
    //移除提示界面
    [self.titleLabel removeFromSuperview];
    self.titleLabel = nil;
    [self.tipsImgView removeFromSuperview];
    self.tipsImgView = nil;
    [self.emptyView removeFromSuperview];
    self.emptyView = nil;
    //移除空数据界面后恢复scrollView滚动功能
    self.scrollEnabled = YES;
}


@end
