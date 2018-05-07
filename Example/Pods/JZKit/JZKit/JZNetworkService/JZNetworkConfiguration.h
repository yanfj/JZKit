//
//  JZNetworkConfiguration.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>


/**
 网络请求配置
 */
@interface JZNetworkConfiguration : NSObject
/**
 * IP/域名
 */
@property (nonatomic, copy) NSString *host;
/**
 * 平台
 */
@property (nonatomic, copy) NSString *platform;
/**
 * 版本号
 */
@property (nonatomic, copy) NSString *version;
/**
 * 盐
 */
@property (nonatomic, copy) NSString *salt;
/**
 * 截取规则
 */
@property (nonatomic, assign) NSRange range;
/**
 * 是否禁用接口日志,默认开启
 */
@property (nonatomic, assign) BOOL disabledLog;
/**
 单例
 
 @return 配置
 */
+ (instancetype)defaultConfiguration;



@end
