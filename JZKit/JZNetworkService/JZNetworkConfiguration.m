//
//  JZNetworkConfiguration.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "JZNetworkConfiguration.h"

static JZNetworkConfiguration *_configuration = nil;

@implementation JZNetworkConfiguration
#pragma mark - 单例
+ (instancetype)defaultConfiguration{
    
    return [[self alloc] init];
    
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _configuration = [super allocWithZone:zone];
    });
    return _configuration;
}
- (instancetype)init{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _configuration = [super init];
    });
    
    return _configuration;
    
}
@end
