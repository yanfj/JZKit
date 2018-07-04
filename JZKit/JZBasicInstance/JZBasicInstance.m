//
//  JZBasicInstance.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZBasicInstance.h"
#import <JZKit/JZGeneralMacros.h>
#import <objc/runtime.h>

static NSString * const instance_key = @"instance";

@implementation JZBasicInstance
#pragma mark - 单例
+ (instancetype)sharedInstance{
    
    id instance = objc_getAssociatedObject(self, &instance_key);
    if (!instance){
        instance = [[super allocWithZone:NULL] init];
        NSLog(@"单例创建:%@",[self class]);
        objc_setAssociatedObject(self, &instance_key, instance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return instance;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    
    return [self sharedInstance] ;
}
- (id)copyWithZone:(struct _NSZone *)zone{
    
    Class class = [self class];
    
    return [class sharedInstance] ;
}

@end
