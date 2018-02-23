//
//  UITableView+JQExtension.m
//  DuoMiPay
//
//  Created by mac on 2017/7/19.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UITableView+JQExtension.h"
#import <objc/runtime.h>

static char EMPTYVIEWKEY;
static char TIPSIMAGEVIEWKEY;
static char TITLELABELKEY;
@implementation UITableView (JQExtension)


- (UIView *)emptyView
{
    return objc_getAssociatedObject(self, &EMPTYVIEWKEY);
}
-(void)setEmptyView:(UIView *)emptyView
{
    if (emptyView != self.emptyView) {
        
        [self willChangeValueForKey:@"emptyView"]; // KVO
        objc_setAssociatedObject(self, &EMPTYVIEWKEY,
                                 emptyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:@"emptyView"]; // KVO
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

-(UILabel *)titleLabel
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
        self.emptyView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.emptyView];
        self.scrollEnabled = NO;//关闭tableView滚动功能
        //提示图片
        self.tipsImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageNamed]];
        self.tipsImgView.frame  = CGRectMake(0, 0, 160, 160);
        self.tipsImgView.contentMode = UIViewContentModeCenter;
        self.tipsImgView.center = CGPointMake(self.emptyView.center.x, rect.size.height/2);
        
        DLog(@"center = %@",NSStringFromCGPoint(self.tipsImgView.center));
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
    }else
    {
        [self dismessEmptyDataTipsView];
    }
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
 
    //移除空数据界面后恢复tableView滚动功能
    self.scrollEnabled = YES;
}



@end
