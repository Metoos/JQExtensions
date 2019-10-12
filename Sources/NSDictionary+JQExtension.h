//
//  NSDictionary+JQExtension.h
//  UniversalProject
//
//  Created by life on 2017/9/5.
//  Copyright © 2017年 JQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JQExtension)




/** 强制固定类型返回值 */
- (NSString *)toString:(NSString *)aKey;

- (NSDictionary *)toDict: (NSString *)key;

- (NSArray *)toArray: (NSString *)key;

- (NSArray *)toStringArray: (NSString *)key;

- (BOOL)toBool: (NSString *)key;

- (int)toInt:(NSString *)aKey;

- (NSInteger)toInteger: (NSString *)key;

- (long long)toLongLong: (NSString *)key;

- (unsigned long long)toUnsignedLongLong:(NSString *)key;

- (double)toDouble: (NSString *)key;

- (float)toFloat:(NSString *)aKey;

@end


@interface NSMutableDictionary (JQExtension)

/** 过滤空对象 */
- (void)jq_setObject:(id)anObject forKey:(id<NSCopying>)aKey;
/** 过滤空对象 并返回本身 */
- (NSMutableDictionary *(^)(NSString *, id))addObjectForKey;
/** 空对象自动转为空字符串填充  并返回本身 */
- (NSMutableDictionary *(^)(NSString *, id))addObjectSupplementForKey;

@end
