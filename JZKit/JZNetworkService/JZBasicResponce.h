//
//  JZBasicResponce.h
//  AFNetworking
//
//  Created by Yan's on 2018/4/27.
//

#import <Foundation/Foundation.h>


/**
 服务器状态码定义
 */
typedef NS_ENUM(NSInteger,JZHTTPResponseCode){
    
    /**
     *  请求取消
     */
    JZHTTPResponseCodeCancel = - 999,
    /**
     *  请求超时
     */
    JZHTTPResponseCodeTimedOut  =  - 1001,
    /**
     *  未知(接收数据格式不正确)
     */
    JZHTTPResponseCodeUnkonw = - 10000,
    
};


#pragma mark - 响应协议
@protocol JZResponceProtocol <NSObject>
@optional
/**
 * 需要替换的键值对
 */
+ (NSDictionary<NSString *,NSString *> *)replacedKeyFromPropertyName;
/**
 * 数组中的模型类
 */
+ (NSDictionary<NSString *,Class> *)objectClassInArray;

@end

/**
 * 响应基类
 */
@interface JZBasicResponce : NSObject<JZResponceProtocol>
/**
 *  状态码
 */
@property (nonatomic, assign) NSInteger code;
/**
 *  描述信息
 */
@property (nonatomic, copy) NSString *msg;
/**
 *  详细字段说明
 */
@property (nonatomic, strong) id data;


@end
