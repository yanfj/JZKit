//
//  JZBasicResponse.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import <Foundation/Foundation.h>
#import "JZResponseProtocol.h"

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
    JZHTTPResponseCodeUnkonw = - 10086,
    
};

/**
 * 响应基类
 */
@interface JZBasicResponse : NSObject<JZResponseProtocol>
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

/**
 * 错误响应
 */
@interface JZErrorResponse : JZBasicResponse


@end
