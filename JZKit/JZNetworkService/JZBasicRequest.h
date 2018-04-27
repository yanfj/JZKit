//
//  JZBasicRequest.h
//  AFNetworking
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>

//请求方式
static NSString * const  POST = @"http_post";
static NSString * const  GET  = @"http_get";

#pragma mark - 请求协议
@protocol JZRequestProtocol <NSObject>
/**
 网络请求方式,默认是GET
 */
- (NSString *)method;
/**
 模块名字
 */
- (NSString *)moduleName;
/**
 模块接口名字
 */
- (NSString *)functionName;
@optional
/**
 是否允许重复请求(默认是 NO)
 */
- (BOOL)allowRepeat;
/**
 需要替换的参数<原参数名 : 新参数名>
 */
- (NSDictionary<NSString *,NSString *> *)replacedKeys;
/**
 加密过的参数名(本地缓存时需要过滤)
 */
- (NSArray<NSString *> *)encryptedKeys;

@end


/**
 请求基类
 */
@interface JZBasicRequest : NSObject<JZRequestProtocol>
/**
 *  需要忽略的参数
 */
@property (nonatomic, strong, readonly) NSMutableSet<NSString *> *ignoreKeys;
/**
 *  最终上传参数
 *
 *  @return 字典
 */
- (NSDictionary *)parameters;
/**
 唯一键值，用来管理请求池
 */
- (NSString *)uniqueKey;

@end
