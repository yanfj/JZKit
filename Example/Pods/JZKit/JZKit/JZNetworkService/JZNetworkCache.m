//
//  JZNetworkCache.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZNetworkCache.h"
#import <YYCache/YYCache.h>

static NSString * const JZHTTPResponseCache = @"JZHTTPResponseCache";

static YYCache *_dataCache = nil;

@implementation JZNetworkCache
#pragma mark - 初始化
+ (void)initialize{
    
    //网络数据缓存
    _dataCache = [YYCache cacheWithName:JZHTTPResponseCache];
    
}
#pragma mark - 保存
+ (void)setCache:(id)data uniqueKey:(NSString *)uniqueKey{
    
    [_dataCache setObject:data forKey:uniqueKey withBlock:nil];
    
}
#pragma mark - 获取数据
+ (id)cacheForUniqueKey:(NSString *)uniqueKey{
    
    return [_dataCache objectForKey:uniqueKey];
    
}

@end
