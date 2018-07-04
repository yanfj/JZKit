//
//  JZBasicRequest.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>
#import "JZRequestProtocol.h"


/**
 请求基类
 */
@interface JZBasicRequest : NSObject<JZRequestProtocol>
/**
 *  需要忽略的参数
 */
@property (nonatomic, strong, readonly) NSMutableSet<NSString *> *ignoreKeys;

@end
