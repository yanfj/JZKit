//
//  UIViewController+BackButtonHandler.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "UIViewController+BackButtonHandler.h"

@implementation UIViewController (BackButtonHandler)

@end

@implementation UINavigationController (ShouldPopOnBackButton)
#pragma mark - 拦截导航栏返回键方法
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    if([self.viewControllers count] < [navigationBar.items count]) {
        return YES;
    }
    
    BOOL shouldPop = YES;
    UIViewController* controller = [self topViewController];
    if([controller respondsToSelector:@selector(jz_navigationShouldPopOnBackButton)]) {
        //走协议方法
        shouldPop = [controller jz_navigationShouldPopOnBackButton];
    }
    
    if(shouldPop) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self popViewControllerAnimated:YES];
        });
    } else {
        //适配iOS 7.1
        for(UIView *subview in [navigationBar subviews]) {
            if(0. < subview.alpha && subview.alpha < 1.) {
                [UIView animateWithDuration:.25 animations:^{
                    subview.alpha = 1.;
                }];
            }
        }
    }
    
    return NO;
    
}
@end
