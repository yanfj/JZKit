//
//  JZSettingsService.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import <Foundation/Foundation.h>

/**
 设置服务
 */
@interface JZSettingsService : NSObject
/**
 * 缓存大小
 *
 * @return MB
 */
+ (CGFloat)cacheSize;
/**
 * 清理缓存
 */
+ (void)clearCache;
/**
 * 清理缓存
 *
 * @param completion 回调
 */
+ (void)clearCacheWithCompletion:(void(^)())completion;
/**
 * 跳转appStore评分
 *
 * @param appid 应用id
 */
+ (void)toAppStoreGradeWithAppId:(NSString *)appId;
/**
 * 监测是否需要更新
 *
 * @param appId 可为nil
 * @param block 回调
 */
+ (void)checkNewReleasesWithAppId:(NSString *)appId
                completionHandler:(void(^)(NSString *localVersion,NSString *storeVersion,NSString *openUrl,BOOL needUpdate))handler;
@end
