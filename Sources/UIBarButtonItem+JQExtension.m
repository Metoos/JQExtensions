//
//  UIBarButtonItem+JQExtension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/27.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIBarButtonItem+JQExtension.h"
#import <objc/runtime.h>
#import "UIButton+WebCache.h"
#import "UIImage+JQExtension.h"
static char CLICK_BLOCK_BACK;
@implementation UIBarButtonItem (JQExtension)

- (instancetype)initWithCustomViewWithImageNamed:(NSString*)imageNamed Click:(ClickBlock)click
{
    self = [self init];
    //使用图片原图
    UIImage *rightImage = [[UIImage imageNamed:imageNamed] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 30, 30);
    [barButton setImage:rightImage forState:UIControlStateNormal];
    [barButton addTarget:self action:@selector(barBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.customView = barButton;
    self.ClickBlock = click;
    
    return self;
}

- (instancetype)initWithCustomViewWithImageUrl:(NSString*)imageUrl placeholderImage:(UIImage*)image Click:(ClickBlock)click
{
    self = [self init];

    
    UIButton *barButton = [UIButton buttonWithType:UIButtonTypeCustom];
    barButton.frame = CGRectMake(0, 0, 30, 30);
    [barButton sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
         //使用图片原图
         UIImage *rightImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //切圆角
         rightImage = [rightImage circleImage];
         [barButton setImage:rightImage forState:UIControlStateNormal];
    }];
    [barButton addTarget:self action:@selector(barBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    self.customView = barButton;
    self.ClickBlock = click;
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title Click:(ClickBlock)click
{
    self = [self initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(barBtnAction:)];

    self.ClickBlock = click;
    
    return self;
}


- (void)barBtnAction:(id)sender
{
    if (self.ClickBlock) {
        self.ClickBlock();
    }
}


- (void)setClickBlock:(ClickBlock)click
{
    objc_setAssociatedObject(self, &CLICK_BLOCK_BACK, click, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(ClickBlock)ClickBlock
{
    return objc_getAssociatedObject(self, &CLICK_BLOCK_BACK);
}

@end
