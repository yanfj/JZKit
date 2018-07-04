//
//  JZNetworkConfiguration.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>


/**
 日志打印等级
 
 - JZNetworkLogLevelDisable: 不打印日志
 - JZNetworkLogLevelOutput: 只打印出参信息
 - JZNetworkLogLevelInputAndOutput: 打印出参及入参信息
 - JZNetworkLogLevelAll: 打印所有网络框架的信息
 */
typedef NS_ENUM(NSInteger , JZNetworkLogLevel){
    
    JZNetworkLogLevelDisable,
    JZNetworkLogLevelOutput,
    JZNetworkLogLevelInputAndOutput,
    JZNetworkLogLevelAll,
    
};


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
 * 接口日志等级，默认 JZNetworkLogLevelDisable
 */
@property (nonatomic, assign) JZNetworkLogLevel logLevel;
/**
 单例
 
 @return 配置
 */
+ (instancetype)defaultConfiguration;



@end
