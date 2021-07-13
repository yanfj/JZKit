//
//  JZBasicRequest.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "JZBasicRequest.h"
#import "JZNetworkConfiguration.h"
#import <JZKit/JZGeneralMacros.h>
#import <YYModel/YYModel.h>
#import <CommonCrypto/CommonDigest.h>


/// md5
/// @param originStr  原字符串
NSString *md5String(NSString *originStr) {
    
    const char *myPasswd = [originStr UTF8String];
    
    unsigned char mdc[ 16 ];
    
    CC_MD5 (myPasswd, ( CC_LONG ) strlen (myPasswd), mdc);
    
    NSMutableString *md5String = [ NSMutableString string ];
    
    for ( int i = 0 ; i< 16 ; i++) {
        
        [md5String appendFormat : @"%02x" ,mdc[i]];
        
    }
    
    return md5String;
    
}


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
    NSMutableDictionary *para = [(NSDictionary *)[self yy_modelToJSONObject] mutableCopy];
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
    
    //请求参数
    NSString *string = [self yy_modelToJSONString];
    //md5值
    NSString *md5Str = md5String(string);
    //唯一键值
    NSString *uniqueKey = [NSString stringWithFormat:@"%@%@%@",[self moduleName],[self functionName],md5Str];
    
    return uniqueKey;
    
}
#pragma mark - YYModel
//(黑名单) [手动过滤Foundation框架类里面的属性]
+ (NSArray *)modelPropertyBlacklist {
    
    return @[@"debugDescription",@"description",@"hash",@"superclass"];
}
// 忽略属性不被转换
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
        
    for (NSString *key in self.ignoreKeys) {
        [dic removeObjectForKey:key];
    }
    return YES;
    
}
@end
