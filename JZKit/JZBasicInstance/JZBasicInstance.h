//
//  JZBasicInstance.h
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import <Foundation/Foundation.h>


/**
 单例基类
 */
@interface JZBasicInstance : NSObject
/**
 * 单例
 */
+ (instancetype)sharedInstance;
@end
