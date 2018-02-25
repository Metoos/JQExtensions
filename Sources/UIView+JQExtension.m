//
//  UIView+JQExtension.m
//  JQExtensions
//
//  Created by zjq on 2017/6/27.
//  Copyright © 2017年 zjq. All rights reserved.
//

#import "UIView+JQExtension.h"

@implementation UIView (JQExtension)

- (CGFloat)jq_left {
    return self.frame.origin.x;
}


- (void)setJq_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


- (CGFloat)jq_top {
    return self.frame.origin.y;
}


- (void)setJq_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


- (CGFloat)jq_right {
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setJq_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (CGFloat)jq_bottom {
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setJq_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)jq_centerX {
    return self.center.x;
}


- (void)setJq_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


- (CGFloat)jq_centerY {
    return self.center.y;
}


- (void)setJq_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)jq_width {
    return self.frame.size.width;
}


- (void)setJq_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)jq_height {
    return self.frame.size.height;
}


- (void)setJq_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)jq_origin {
    return self.frame.origin;
}


- (void)setJq_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


- (CGSize)jq_size {
    return self.frame.size;
}


- (void)setJq_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (UIViewController *)jq_viewController{
    for (UIView* next = self; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
