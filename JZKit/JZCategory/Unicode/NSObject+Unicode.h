//
//  NSObject+Unicode.h
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import <Foundation/Foundation.h>

/**
 编码格式化
 */
@interface NSObject (Unicode)
/**
 Unicode
 */
+ (NSString *)stringByReplaceUnicode:(NSString *)string;

@end
