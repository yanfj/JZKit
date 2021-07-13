//
//  JZBasicResponse.m
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import "JZBasicResponse.h"
#import <YYModel/YYModel.h>

@implementation JZBasicResponse
#pragma mark - YYModel
// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    if ([self respondsToSelector:@selector(objectClassInArray)]) {
        
        return [self objectClassInArray];
    }
    
    return [NSDictionary dictionary];
}
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        
        return [self replacedKeyFromPropertyName];
    }
    
    return [NSDictionary dictionary];
}

//(黑名单) [手动过滤Foundation框架类里面的属性]
+ (NSArray *)modelPropertyBlacklist {
    
    return @[@"debugDescription",@"description",@"hash",@"superclass"];
}
#pragma mark - 描述
- (NSString *)description{
    
    NSString *desc = [self yy_modelToJSONString];
    
    return desc;
}

@end

#pragma mark - 错误响应
@implementation JZErrorResponse


@end
