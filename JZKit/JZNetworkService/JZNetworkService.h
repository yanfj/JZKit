//
//  JZNetworkService.h
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import <Foundation/Foundation.h>
#import "JZRequestProtocol.h"
#import "JZResponseProtocol.h"

/**
 *  请求数据枚举
 */
typedef NS_ENUM(NSUInteger, JZRequestSerializer) {
    /**
     *   设置请求数据为JSON格式
     */
    JZRequestSerializerJSON,
    /**
     *   设置请求数据为二进制格式
     */
    CPRequestSerializerHTTP,
};
/**
 *  响应数据枚举
 */
typedef NS_ENUM(NSUInteger, JZResponseSerializer) {
    /**
     *   设置响应数据为JSON格式
     */
    JZResponseSerializerJSON,
    /**
     *   设置响应数据为二进制格式
     */
    JZResponseSerializerHTTP,
};
/**
 *  数据操作枚举
 *
 *  常用组合：
 *  (JZHTTPDataOperate_LoadFromLocal | JZHTTPDataOperate_LoadFromRemote | JZHTTPDataOperate_UpdataToLocal) 从本地获取，没有则请求网络，再缓存本地
 */
typedef NS_ENUM(NSInteger, JZHTTPDataOperate) {
    /**
     *  从本地缓存数据库加载
     */
    JZHTTPDataOperate_LoadFromLocal         =   0x0001,
    /**
     *  从远处服务器加载
     */
    JZHTTPDataOperate_LoadFromRemote        =   0x0010,
    /**
     *  更新到本地数据库
     */
    JZHTTPDataOperate_UpdataToLocal         =   0x0100,
};


@class JZErrorResponse;

/**
 成功回调

 @param responseObject 响应体
 */
typedef void(^JZSuccessBlock)(id<JZResponseProtocol> responseObject);

/**
 失败回调

 @param errorObject 错误响应体
 @param error 错误信息
 */
typedef void(^JZFailureBlock)(JZErrorResponse* errorObject,NSError *error);

/**
 数据请求管理者（负责分发数据请求，处理响应）
 */
@interface JZNetworkService : NSObject
#pragma mark - 网络请求
/**
 *  从网络获取数据请求获取数据
 *
 *  @param request    请求参数对象
 *  @param successBlock  成功响应
 *  @param failureBlock  失败响应
 */
+ (void)fetchDataWithRequest:(id<JZRequestProtocol>)request
                successBlock:(JZSuccessBlock)successBlock
                failureBlock:(JZFailureBlock)failureBlock;
/**
 *  通过请求获取数据(可操作模式)
 *
 *  @param request    请求参数对象
 *  @param operate    操作
 *  @param successBlock  成功响应
 *  @param failureBlock  失败响应
 */
+ (void)fetchDataWithRequest:(id<JZRequestProtocol>)request
                     operate:(JZHTTPDataOperate)operate
                successBlock:(JZSuccessBlock)successBlock
                failureBlock:(JZFailureBlock)failureBlock;
/**
 *  通过请求获取数据(优先从缓存读,请求到数据再返回)
 *
 *  @param request          请求参数对象
 *  @param responseCache    缓存数据
 *  @param successBlock  成功响应
 *  @param failureBlock  失败响应
 */
+ (void)fetchDataWithRequest:(id<JZRequestProtocol>)request
               responseCache:(JZSuccessBlock)responseCache
                successBlock:(JZSuccessBlock)successBlock
                failureBlock:(JZFailureBlock)failureBlock;
#pragma mark - 取消网络请求
/**
 *  批量取消请求获取数据
 *
 *  @param uniqueKeys  请求体唯一键值组
 */
+ (void)cancelRequests:(NSArray<NSString *> *)uniqueKeys;
/**
 *  取消请求获取数据
 *
 *  @param uniqueKey  请求体唯一键值
 */
+ (void)cancelRequest:(NSString *)uniqueKey;
/**
 *  取消当前请求池中所有请求
 *
 */
+ (void)cancelAllRequests;
#pragma mark - 重置AFHTTPSessionManager相关属性
/**
 *  设置网络请求参数的格式:默认为JSON格式
 *
 *  @param requestSerializer JZRequestSerializerJSON(JSON格式),JZRequestSerializerHTTP(二进制格式),
 */
+ (void)setRequestSerializer:(JZRequestSerializer)requestSerializer;

/**
 *  设置服务器响应数据格式:默认为JSON格式
 *
 *  @param responseSerializer JZResponseSerializerJSON(JSON格式),JZResponseSerializerHTTP(二进制格式)
 */
+ (void)setResponseSerializer:(JZResponseSerializer)responseSerializer;
/**
 *  设置请求头
 *
 *  @param value 值
 *  @param field 键
 */
+ (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
/**
 *  设置请求超时时间(默认为15s)
 *
 *  @param timeoutInterval 时长
 */
+ (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval;
/**
 *  是否打开网络状态转圈菊花(默认打开)
 *
 *  @param open YES(打开), NO(关闭)
 */
+ (void)openNetworkActivityIndicator:(BOOL)open;

@end

#pragma mark - 网络状态枚举
/**
 *  网络状态枚举
 */
typedef NS_ENUM(NSUInteger, JZNetworkStatus) {
    /**
     *  未知网络
     */
    JZNetworkStatusUnknown,
    /**
     *  无网络
     */
    JZNetworkStatusNotReachable,
    /**
     *  手机网络
     */
    JZNetworkStatusViaWWAN,
    /**
     * WIFI网络
     */
    JZNetworkStatusViaWiFi,
};

#pragma mark - 网络状态通知

FOUNDATION_EXTERN  NSString *const JZNotificationNetworkStatusUnknown;       //未知网络
FOUNDATION_EXTERN  NSString *const JZNotificationNetworkStatusNotReachable;  //无网络
FOUNDATION_EXTERN  NSString *const JZNotificationNetworkStatusViaWWAN;       //蜂窝网络
FOUNDATION_EXTERN  NSString *const JZNotificationNetworkStatusViaWiFi;       //WIFI

#pragma mark - 网络情况监测
/**
 网络情况
 */
@interface JZNetworkService (NetworkStatus)
/**
 实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)startNetworkStatusWithBlock:(void(^)(JZNetworkStatus status))networkStatus;
/**
 * 是否有网
 */
+ (BOOL)isReachable;
/**
 * 是否是蜂窝网络
 */
+ (BOOL)isWWANNetwork;
/**
 * 是否是WIFI
 */
+ (BOOL)isWiFiNetwork;
@end
