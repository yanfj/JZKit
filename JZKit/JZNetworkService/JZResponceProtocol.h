//
//  JZResponceProtocol.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>

/**
 响应协议
 */
@protocol JZResponceProtocol <NSObject>
@optional
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
