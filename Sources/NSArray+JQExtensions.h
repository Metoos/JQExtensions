//
//  NSArray+JQExtensions.h
//  CreateEnjoy
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 hdyg. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (JQExtensions)


/**
 *返回传入类的所有属性名
 *@param cls  类
 */

+ (instancetype)getProperties:(Class)cls;


/**
 *返回传入类的某后缀的所有属性
 *@param cls  实例对象
 *@param hasSuffix  属性后缀
 *@retrun  属性数组
 */
+ (NSArray *)getProperties:(NSObject *)cls withHasSuffix:(NSString *)hasSuffix;

@end

NS_ASSUME_NONNULL_END
