//
//  NSObject+MethodSwizzling.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>

/**
 黑魔法
 */
@interface NSObject (MethodSwizzling)
/**
 方法交换

 @param origSel 旧方法
 @param swizSel 新方法
 */
+ (void)jz_swizzleMethodWithOriginalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel;

@end
