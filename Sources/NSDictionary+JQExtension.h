//
//  NSDictionary+JQExtension.h
//  UniversalProject
//
//  Created by life on 2017/9/5.
//  Copyright © 2017年 JQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JQExtension)

- (NSString *) toString:(NSString *)aKey;
- (int) toInt:(NSString *)aKey;
- (float) toFloat:(NSString *)aKey;

- (NSString *)jsonString: (NSString *)key;

- (NSDictionary *)jsonDict: (NSString *)key;
- (NSArray *)jsonArray: (NSString *)key;
- (NSArray *)jsonStringArray: (NSString *)key;


- (BOOL)jsonBool: (NSString *)key;
- (NSInteger)jsonInteger: (NSString *)key;
- (long long)jsonLongLong: (NSString *)key;
- (unsigned long long)jsonUnsignedLongLong:(NSString *)key;

- (double)jsonDouble: (NSString *)key;

@end
