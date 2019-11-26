//
//  JZNetworkCache.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import <Foundation/Foundation.h>

/**
 网络数据缓存
 */
@interface JZNetworkCache : NSObject
/**
 *  缓存网络数据,根据请求体的uniqueKey
 *  做KEY存储数据, 这样就能缓存多级页面多个用户的数据
 *
 *  @param data   服务器返回的数据
 *  @param uniqueKey  唯一键值(业务参数)
 */
+ (void)setCache:(id)data uniqueKey:(NSString *)uniqueKey;
/**
 *  根据请求的 URL与parameters 取出缓存数据
 *
 *  @param uniqueKey  唯一键值(业务参数)
 *
 *  @return 缓存的服务器数据
 */
+ (id)cacheForUniqueKey:(NSString *)uniqueKey;

@end
