//
//  UIView+JQFontSize.m
//  FontSizeModify
//
//  Created by dyw on 16/10/22.
//  Copyright © 2016年 dyw. All rights reserved.
//

#import "UIView+JQFontSize.h"
#import <objc/runtime.h>

#define JQIgnoreTagKey @"JQIgnoreTagKey"
#define JQFontScaleKey @"JQFontScaleKey"

#define ScrenScale [UIScreen mainScreen].bounds.size.width/320.0

@implementation UIView (JQFontSize)
/**
 设置需要忽略的空间tag值
 
 @param tagArr tag值数组
 */
+ (void)setIgnoreTags:(NSArray<NSNumber*> *)tagArr{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:tagArr forKey:JQIgnoreTagKey];
    [defaults synchronize];
}

/**
 设置字体大小比例
 
 @param value 需要设置的比例
 */
+ (void)setFontScale:(CGFloat)value{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@(value) forKey:JQFontScaleKey];
    [defaults synchronize];
}

+ (NSArray *)getIgnoreTags{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *ignoreTagsArr = [defaults objectForKey:JQIgnoreTagKey];
    return ignoreTagsArr.count?ignoreTagsArr:0;
}

+ (CGFloat)getFontScale{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber *valueNum = [defaults objectForKey:JQFontScaleKey];
    return valueNum?valueNum.floatValue:1.0;
}

@end

@interface UILabel (JQFontSize)

@end

@interface UIButton (JQFontSize)

@end

@interface UITextField (JQFontSize)

@end

@interface UITextView (JQFontSize)

@end

@implementation UILabel (JQFontSize)

+ (void)load{
    if(!JQUILabelEnable) return;
    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
//        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
//        NSArray *ignoreTags = [UIView getIgnoreTags];
//        for (NSNumber *num in ignoreTags) {
//            if(self.tag == num.integerValue) return self;
//        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}


- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
//        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
//        NSArray *ignoreTags = [UIView getIgnoreTags];
//        for (NSNumber *num in ignoreTags) {
//            if(self.tag == num.integerValue) return self;
//        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end

@implementation UIButton (JQFontSize)

+ (void)load {
    if(!JQUIButtonEnable) return;

    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        CGFloat fontSize = self.titleLabel.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.titleLabel.font = [self.titleLabel.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
//        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
//        NSArray *ignoreTags = [UIView getIgnoreTags];
//        for (NSNumber *num in ignoreTags) {
//            if(self.tag == num.integerValue) return self;
//        }
        CGFloat fontSize = self.titleLabel.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.titleLabel.font = [self.titleLabel.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end

@implementation UITextField (JQFontSize)

+ (void)load {
    if(!JQUITextFieldEnable) return;

    Method imp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(imp, myImp);
    
    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

- (id)myInitWithFrame:(CGRect)frame{
    [self myInitWithFrame:frame];
    if(self){
//        //代码创建的时候 还不能拿到之后设置的tag 所以无法判断忽略项
//        NSArray *ignoreTags = [UIView getIgnoreTags];
//        for (NSNumber *num in ignoreTags) {
//            if(self.tag == num.integerValue) return self;
//        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

@end

@implementation UITextView (JQFontSize)

+ (void)load {
    if(!JQUITextViewEnable) return;

    Method ibImp = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method myIbImp = class_getInstanceMethod([self class], @selector(myInitWithCoder:));
    method_exchangeImplementations(ibImp, myIbImp);
    
//    Method cmp = class_getInstanceMethod([self class], @selector(initWithFrame:));
//    Method myCmp = class_getInstanceMethod([self class], @selector(myInitWithFrame:));
//    method_exchangeImplementations(cmp, myCmp);
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        NSArray *ignoreTags = [UIView getIgnoreTags];
        for (NSNumber *num in ignoreTags) {
            if(self.tag == num.integerValue) return self;
        }
        CGFloat fontSize = self.font.pointSize;
        CGFloat scale = [UIView getFontScale];
        self.font = [self.font fontWithSize:fontSize*(scale?:ScrenScale)];
    }
    return self;
}

//- (id)myInitWithFrame:(CGRect)frame{
//    [self myInitWithFrame:frame];
//    if(self){
//        //textView 此时的 self.font 还是 nil 所以无法修改
//        CGFloat fontSize = self.font.pointSize;
//        self.font = [self.font fontWithSize:fontSize*ScrenScale];
//    }
//    return self;
//}


@end
