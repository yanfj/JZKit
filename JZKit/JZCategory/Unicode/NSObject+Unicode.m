//
//  NSObject+Unicode.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "NSObject+Unicode.h"

@implementation NSObject (Unicode)
+ (NSString *)stringByReplaceUnicode:(NSString *)string{
    NSMutableString *convertedString = [string mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U" withString:@"\\u" options:0 range:NSMakeRange(0, convertedString.length)];
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}
@end
