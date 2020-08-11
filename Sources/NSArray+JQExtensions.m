//
//  NSArray+JQExtensions.m
//  CreateEnjoy
//
//  Created by mac on 2019/7/3.
//  Copyright © 2019 hdyg. All rights reserved.
//

#import "NSArray+JQExtensions.h"
#import <objc/runtime.h>
@implementation NSArray (JQExtensions)

//返回当前类的所有属性
+ (instancetype)getProperties:(Class)cls
{
    unsigned int count; //记录属性个数
    objc_property_t *properties = class_copyPropertyList(cls, &count);
    // 遍历
    NSMutableArray *mArray = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        
        // An opaque type that represents an Objective-C declared property.
        // objc_property_t 属性类型
        objc_property_t property = properties[i];
        // 获取属性的名称 C语言字符串
        const char *cName = property_getName(property);
        // 转换为Objective C 字符串
        NSString *name = [NSString stringWithCString:cName encoding:NSUTF8StringEncoding];
        [mArray addObject:name];
        
        
//        const char *cAttributes = property_getAttributes(property);
//        NSString *attributes = [NSString stringWithCString:cAttributes encoding:NSUTF8StringEncoding];
//        NSLog(@"attributes = %@",attributes);
        /*property_getAttributes函数返回objc_property_attribute_t结构体列表，objc_property_attribute_t结构体包含name和value，常用的属性如下：
        
        属性类型 name值：T value：变化
        
        编码类型 name值：C(copy) &(strong) W(weak)空(assign) 等 value：无
        
        非/原子性 name值：空(atomic) N(Nonatomic) value：无
        
        变量名称 name值：V value：变化
        
         使用property_getAttributes获得的描述是property_copyAttributeList能获取到的所有的name和value的总体描述，如 T@"NSDictionary",C,N,V_dict1
             T@"UITextField",W,N,V_alipayTextField
             Tf,N,V_countf
         */
        
//        [self typeWithPropertyType:attributes];
    }
    free(properties);
    return mArray.copy;
    
}

/**
 *返回传入类的某后缀的所有属性
 *@param cls  实例对象
 *@param hasSuffix  属性后缀
 *@retrun  属性数组
 */
+ (NSArray *)getProperties:(NSObject *)cls withHasSuffix:(NSString *)hasSuffix
{
    NSArray *properties = [NSArray getProperties:cls.class];
    NSMutableArray *ary = [[NSMutableArray alloc]init];
    for (NSString *propertyName in properties) {
        if ([propertyName hasSuffix:hasSuffix]) {
            id obj = [cls valueForKey:propertyName];
            if (obj) {
                [ary addObject:obj];
            }
        }
    }
    return ary;
}


+ (NSString*)typeWithPropertyType:(NSString*)ivarType{
    
    NSString * typeString = @"";
    
    if(![ivarType isKindOfClass:[NSString class]]){
        
        return typeString;
    }
    
    if([ivarType isEqualToString:@"i"]){
        
        typeString = @"int";
        
    }else if([ivarType isEqualToString:@"f"]){
        
        typeString = @"float";
        
    }else if([ivarType isEqualToString:@"d"]){
        
        typeString = @"double|CGFloat";
        
    }else if([ivarType isEqualToString:@"q"]){
        
        typeString = @"NSInteger";
        
    }else if([ivarType isEqualToString:@"B"]){
        
        typeString = @"BOOL";
        
    }else{
        
        typeString = ivarType;
        
    }
    
    return typeString;
    
}

@end
