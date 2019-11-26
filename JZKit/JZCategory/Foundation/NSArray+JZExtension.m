//
//  NSArray+JZExtension.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "NSArray+JZExtension.h"

@implementation NSArray (JZExtension)
#pragma mark - 检查是否为空
- (BOOL)jz_checkNotNullAtIndex:(NSUInteger)index{
    
    //越界
    if (index >= [self count]) {
        
        return NO;
    }
    
    id value = [self objectAtIndex:index];
    
    if (value == [NSNull null]) {
        
        return NO;
    }
    
    return YES;
    
}
@end
