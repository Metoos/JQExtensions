//
//  NSDictionary+JQExtension.m
//  UniversalProject
//
//  Created by life on 2017/9/5.
//  Copyright © 2017年 JQ. All rights reserved.
//

#import "NSDictionary+JQExtension.h"

@implementation NSDictionary (JQExtension)

- (NSString *) toString:(NSString *)aKey{
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

-(int) toInt:(NSString *)aKey{
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


-(float) toFloat:(NSString *)aKey{
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

- (NSString *)jsonString: (NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]])
    {
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]])
    {
        return [object stringValue];
    }
    return nil;
}

- (NSDictionary *)jsonDict: (NSString *)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:[NSDictionary class]] ? object : nil;
}


- (NSArray *)jsonArray: (NSString *)key
{
    id object = [self objectForKey:key];
    return [object isKindOfClass:[NSArray class]] ? object : nil;
    
}

- (NSArray *)jsonStringArray: (NSString *)key
{
    NSArray *array = [self jsonArray:key];
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

- (BOOL)jsonBool: (NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object boolValue];
    }
    return NO;
}

- (NSInteger)jsonInteger: (NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object integerValue];
    }
    return 0;
}

- (long long)jsonLongLong: (NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object longLongValue];
    }
    return 0;
}

- (unsigned long long)jsonUnsignedLongLong:(NSString *)key
{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object unsignedLongLongValue];
    }
    return 0;
}


- (double)jsonDouble: (NSString *)key{
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSNumber class]])
    {
        return [object doubleValue];
    }
    return 0;
}

@end
