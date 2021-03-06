//
//  JZResponseProtocol.h
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import <Foundation/Foundation.h>

/**
 响应协议
 */
@protocol JZResponseProtocol <NSObject>
@optional
/**
 *  详细字段说明
 */
@property (nonatomic, strong) id data;
/**
 *  是否请求成功
 */
@property (nonatomic, assign,readonly) BOOL success;
/**
 * 需要替换的键值对
 */
+ (NSDictionary<NSString *,NSString *> *)replacedKeyFromPropertyName;
/**
 * 数组中的模型类
 */
+ (NSDictionary<NSString *,Class> *)objectClassInArray;

@end
