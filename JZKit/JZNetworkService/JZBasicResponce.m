//
//  JZBasicResponce.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZBasicResponce.h"
#import <MJExtension/MJExtension.h>

@implementation JZBasicResponce
#pragma mark - MJExtension
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        
        return [self replacedKeyFromPropertyName];
    }
    
    return [NSDictionary dictionary];
}
+ (NSDictionary *)mj_objectClassInArray{
    
    if ([self respondsToSelector:@selector(objectClassInArray)]) {
        
        return [self objectClassInArray];
    }
    
    return [NSDictionary dictionary];
}
- (BOOL)success{
    
    return (self.code == 200);
    
}
#pragma mark - MJKeyValue(手动过滤Foundation框架类里面的属性)
+ (NSArray *)mj_ignoredPropertyNames{
    
    return @[@"debugDescription",@"description",@"hash",@"superclass"];
    
}
#pragma mark - 描述
- (NSString *)description{
    
    NSString *desc = [NSString stringWithFormat:@"%@",[self mj_keyValues]];
    
    return desc;
}

@end

#pragma mark - 错误响应
@implementation JZErrorResponce


@end
