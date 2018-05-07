//
//  UIViewController+NavigationBarBottomline.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "UIViewController+NavigationBarBottomline.h"
#import <objc/runtime.h>

@implementation UIViewController (NavigationBarBottomline)
#pragma mark - 设置底线
- (void)setJz_bottomline:(UIImageView *)jz_bottomline{
    
    objc_setAssociatedObject(self, @selector(jz_bottomline), jz_bottomline, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
#pragma mark - 获取底线
- (UIImageView *)jz_bottomline{
    
    return objc_getAssociatedObject(self, _cmd);
    
}
#pragma mark - 查找底线
- (UIImageView *)searchBottomline:(UIView *)bar{
    
    if ([bar isKindOfClass:UIImageView.class] && bar.bounds.size.height <= 1.0) {
        return (UIImageView *)bar;
    }
    for (UIView *subview in bar.subviews) {
        UIImageView *imageView = [self searchBottomline:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark - 设置底线
- (void)jz_searchBottomline{
    
    if (self.navigationController.navigationBar) {
        
        UIImageView *line = [self searchBottomline:self.navigationController.navigationBar];
        
        [self setJz_bottomline:line];
        
    }
    
}
@end
