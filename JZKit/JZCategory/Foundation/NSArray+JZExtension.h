//
//  NSArray+JZExtension.h
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import <Foundation/Foundation.h>

@interface NSArray (JZExtension)
/**
 检查是否为空
 
 @param index 索引
 @return 布尔值
 */
- (BOOL)jz_checkNotNullAtIndex:(NSUInteger)index;
@end
