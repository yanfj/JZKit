//
//  JZGeographicCache.m
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import "JZGeographicCache.h"
#import <YYCache/YYCache.h>

static NSString * const JZGeographicData  = @"JZGeographicData";

static YYCache *_dataCache = nil;

@implementation JZGeographicCache
#pragma mark - 初始化
+ (void)initialize{
    
    //数据储存在Document下
    NSString *documentFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [documentFolder stringByAppendingPathComponent:JZGeographicData];
    _dataCache = [YYCache cacheWithPath:path];
    
}
#pragma mark - 保存
+ (void)setData:(id)data key:(NSString *)key{
    
    [_dataCache setObject:data forKey:key withBlock:nil];
}
#pragma mark - 获取数据
+ (id)dataForKey:(NSString *)key{
    
    return [_dataCache objectForKey:key];
}

@end
