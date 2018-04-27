//
//  NSArray+Unicode.m
//  Pods-JZKit_Example
//
//  Created by Yan's on 2018/4/26.
//

#import "NSArray+Unicode.h"
#import "NSObject+Unicode.h"
#import "NSObject+MethodSwizzling.h"

@implementation NSArray (Unicode)
+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self jz_swizzleMethods:[self class] originalSelector:@selector(description) swizzledSelector:@selector(replaceDescription)];
        [self jz_swizzleMethods:[self class] originalSelector:@selector(descriptionWithLocale:) swizzledSelector:@selector(replaceDescriptionWithLocale:)];
        [self jz_swizzleMethods:[self class] originalSelector:@selector(descriptionWithLocale:indent:) swizzledSelector:@selector(replaceDescriptionWithLocale:indent:)];
    });
    
}
- (NSString *)replaceDescription {
    return [NSObject stringByReplaceUnicode:[self replaceDescription]];
}

- (NSString *)replaceDescriptionWithLocale:(nullable id)locale {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale]];
}

- (NSString *)replaceDescriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [NSObject stringByReplaceUnicode:[self replaceDescriptionWithLocale:locale indent:level]];
}
@end
