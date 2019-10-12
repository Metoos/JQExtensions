//
//  NSDictionary+JQExtension.m
//  UniversalProject
//
//  Created by life on 2017/9/5.
//  Copyright © 2017年 JQ. All rights reserved.
//

#import "NSDictionary+JQExtension.h"

@implementation NSDictionary (JQExtension)

- (NSString *)toString:(NSString *)aKey{
    if ([self isKindOfClass:[NSDictionary class]]) {
        id idval = [self objectForKey:aKey];
        
        if ([idval isKindOfClass:[NSNull class]] || idval == [NSNull null]){
            return @"";
        }
        if (idval && idval != [NSNull null]){
            if ([idval respondsToSelector:@selector(length)])
                return [self objectForKey:aKey];
            else if ([idval respondsToSelector:@selector(intValue)]){
                return [NSString stringWithFormat:@"%d", [[self objectForKey:aKey] intValue]];
            }
        }else{
            return @"";
        }
        return @"";
    }else{
        return @"";
    }
    
}

- (NSDictionary *)toDict:(NSString *)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:[NSDictionary class]] ? object : nil;
}

- (NSArray *)toArray:(NSString *)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:[NSArray class]] ? object : nil;
    
}

- (NSArray *)toStringArray:(NSString *)key
{
    NSArray *array = [self toArray:key];
    BOOL invalid = NO;
    for (id item in array)
    {
        if (![item isKindOfClass:[NSString class]])
        {
            invalid = YES;
        }
    }
    return invalid ? nil : array;
}

- (BOOL)toBool:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object boolValue];
    }
    return NO;
}

- (int)toInt:(NSString *)aKey{
    if ([self isKindOfClass:[NSDictionary class]]) {
        id idval = [self objectForKey:aKey];
        if (idval && idval != [NSNull null] && [idval respondsToSelector:@selector(intValue)]){
            return [[self objectForKey:aKey] intValue];
        }else{
            return 0;
        }
        
        return 0;
    }else{
        return 0;
    }
}

- (NSInteger)toInteger: (NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object integerValue];
    }
    return 0;
}

- (long long)toLongLong:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object longLongValue];
    }
    return 0;
}

- (unsigned long long)toUnsignedLongLong:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object unsignedLongLongValue];
    }
    return 0;
}


- (double)toDouble:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object doubleValue];
    }
    return 0;
}


- (float)toFloat:(NSString *)aKey{
    if ([self isKindOfClass:[NSDictionary class]]) {
        id idval = [self objectForKey:aKey];
        if (idval && idval != [NSNull null] && [idval respondsToSelector:@selector(floatValue)]){
            return [[self objectForKey:aKey] floatValue];
        }else{
            return 0;
        }
        return 0;
    }else{
        return 0;
    }
}

//判断是否为整形：
- (BOOL)isPureInt:(NSString*) string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt: &val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat:(NSString *) string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}




@end

@implementation NSMutableDictionary (JQExtension)

- (void)jq_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject && aKey) {
        [self setObject:anObject forKey:aKey];
    }
    
}
- (NSMutableDictionary *(^)(NSString *, id))addObjectForKey
{
    return ^NSMutableDictionary *(NSString *key, id object){
        [self jq_setObject:object forKey:key];
        return self;
    };
}

- (NSMutableDictionary *(^)(NSString *, id))addObjectSupplementForKey
{
    return ^NSMutableDictionary *(NSString *key, id object){
        [self jq_setObject:object?:@"" forKey:key];
        return self;
    };
}


@end
