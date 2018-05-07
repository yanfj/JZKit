//
//  JZGeographicCache.h
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import <Foundation/Foundation.h>

/**
 地理缓存
 */
@interface JZGeographicCache : NSObject
/**
 *  根据KEY值储存数据
 *
 *  @param data 需要存储的数据
 *  @param key 唯一键值
 */
+ (void)setData:(id)data key:(NSString *)key;
/**
 *  根据KEY值取出数据
 *
 * @param key 唯一键值
 * @return 缓存的数据
 */
+ (id)dataForKey:(NSString *)key;

@end
