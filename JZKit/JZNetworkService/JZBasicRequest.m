//
//  JZBasicRequest.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "JZBasicRequest.h"
#import "JZNetworkConfiguration.h"
#import <MJExtension/MJExtension.h>
#import <JZKit/JZGeneralMacros.h>

//需要被过滤的初始键值
static NSString * const key_ignoreKeys  = @"ignoreKeys";

@interface JZBasicRequest()
/**
 *  需要忽略的参数
 */
@property (nonatomic, strong) NSMutableSet<NSString *> *ignoreKeys;

@end


@implementation JZBasicRequest
#pragma mark - Getter&Setter
- (NSMutableSet<NSString *> *)ignoreKeys{
    
    if (_ignoreKeys == nil) {
        
        _ignoreKeys = [NSMutableSet setWithObject:key_ignoreKeys];
    }
    
    return _ignoreKeys;
}
#pragma mark -  JZRequestProtocol
- (NSString *)method{
    
    return GET;
}
- (NSString *)moduleName{
    
    return [NSString string];
}
- (NSString *)functionName{
    
    return [NSString string];
}
- (BOOL)allowRepeat{
    
    return NO;
}
#pragma mark - 最终上传参数
- (NSDictionary *)parameters{
    
    //模型转字典
    NSMutableDictionary *para = [self mj_keyValuesWithIgnoredKeys:[self.ignoreKeys allObjects]];
    //替换键值
    para = [self replaceKeys:para];
    
    if ([JZNetworkConfiguration defaultConfiguration].logLevel >= JZNetworkLogLevelInputAndOutput) {
        
        NSLog(@"[入参]--[%@]:%@",[self functionName],para);
    }
    
    return para;
}
#pragma mark - 替换键值
- (NSMutableDictionary *)replaceKeys:(NSMutableDictionary *)para{
    
    if ([self respondsToSelector:@selector(replacedKeys)]) {
        
        NSDictionary<NSString *,NSString *> * dict = [self replacedKeys];
        
        for (NSString *key in dict.allKeys) {
            
            [para setObject:para[key] forKey:dict[key]];
            [para removeObjectForKey:key];
            
        }
    }
    
    return para;
}
#pragma mark - 唯一键值，用来管理请求池
- (NSString *)uniqueKey{
    
    //创建过滤集合
    NSMutableSet<NSString *>  *ignoreSet = [NSMutableSet set];
    //添加过滤参数
    [ignoreSet addObjectsFromArray:[self.ignoreKeys allObjects]];

    //过滤加密的参数
    if ([self respondsToSelector:@selector(encryptedKeys)]) {
        [ignoreSet addObjectsFromArray:[self encryptedKeys]];
    }
    //模型转字典
    NSMutableDictionary *para = [self mj_keyValuesWithIgnoredKeys:[ignoreSet allObjects]];
    //替换
    para = [self replaceKeys:para];
    //唯一键值
    NSString *uniqueKey = [NSString stringWithFormat:@"%@%@%@",[self moduleName],[self functionName],[para mj_JSONString]];
    
    return uniqueKey;
    
}
#pragma mark - MJKeyValue(手动过滤Foundation框架类里面的属性)
+ (NSArray *)mj_ignoredPropertyNames{
    
    return @[@"debugDescription",@"description",@"hash",@"superclass"];
    
}
@end
