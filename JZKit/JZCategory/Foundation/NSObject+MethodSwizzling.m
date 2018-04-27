//
//  NSObject+MethodSwizzling.m
//  Pods-JZKit_Example
//
//  Created by Yan's on 2018/4/26.
//

#import "NSObject+MethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (MethodSwizzling)
+ (void)jz_swizzleMethods:(Class)class originalSelector:(SEL)origSel swizzledSelector:(SEL)swizSel{
    
    Method origMethod = class_getInstanceMethod(class, origSel);
    Method swizMethod = class_getInstanceMethod(class, swizSel);
    
    BOOL didAddMethod = class_addMethod(class, origSel, method_getImplementation(swizMethod), method_getTypeEncoding(swizMethod));
    if (didAddMethod) {
        class_replaceMethod(class, swizSel, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, swizMethod);
    }
    
}
@end
