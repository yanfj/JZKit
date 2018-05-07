//
//  JZProgressHUD.m
//  JZKit
//
//  Created by Yan's on 2018/4/28.
//

#import "JZProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <JZKit/JZGeneralMacros.h>

static NSBundle *_bundle = nil;
static MBProgressHUD *_hud = nil;
static UIWindow *_keyWindow = nil;

@implementation JZProgressHUD
#pragma mark - 初始化
+ (void)initialize{
    
    if (_keyWindow == nil) {
        _keyWindow = [UIApplication sharedApplication].keyWindow;
    }
    if (_hud == nil) {
        _hud = [[MBProgressHUD alloc] initWithView:_keyWindow];
        _hud.removeFromSuperViewOnHide = YES;
        _hud.minSize = CGSizeMake(UI_SCALE(100), UI_SCALE(100));
        _hud.margin = UI_SCALE(15);
        _hud.label.numberOfLines = 0;
        _hud.label.font = FONT(UI_SCALE(14));
    }
    if (_bundle == nil) {
        NSBundle *classBundle = [NSBundle bundleForClass:[JZProgressHUD class]];
        NSURL *url = [classBundle URLForResource:@"JZProgressHUD" withExtension:@"bundle"];
        _bundle = [NSBundle bundleWithURL:url];
    }
    
}
#pragma mark - 显示(小菊花图标)
+ (void)show{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.label.text = EMPTY_STRING;
        
        [_keyWindow addSubview:_hud];
        
        [_hud showAnimated:YES];
        
    });
    
}
#pragma mark - 显示状态(小菊花图标)
+ (void)showStatus:(NSString *)status{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _hud.mode = MBProgressHUDModeIndeterminate;
        _hud.label.text = status;
        
        [_keyWindow addSubview:_hud];
        
        [_hud showAnimated:YES];
        
    });
    
}
#pragma mark - 显示成功
+ (void)showSuccessWithStatus:(NSString *)status completion:(JZProgressHUDCompletionBlock)completion{
    
    [self showSuccessWithStatus:status hideAfterDelay:0.5f completion:completion];
    
}
+ (void)showSuccessWithStatus:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion{
    
    [self customizeImageName:@"hud_success" status:status hideAfterDelay:delay completion:completion];
    
}
#pragma mark - 显示失败
+ (void)showErrorWithStatus:(NSString *)status  completion:(JZProgressHUDCompletionBlock)completion{
    
    [self showErrorWithStatus:status hideAfterDelay:1.f completion:completion];
    
}
+ (void)showErrorWithStatus:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion{
    
    
    [self customizeImageName:@"hud_error" status:status hideAfterDelay:delay completion:completion];
    
}
#pragma mark - 显示提示
+ (void)showTipsWithStatus:(NSString *)status  completion:(JZProgressHUDCompletionBlock)completion{
    
    [self showTipsWithStatus:status hideAfterDelay:1.5f completion:completion];
    
}
+ (void)showTipsWithStatus:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion{
    
    [self customizeImageName:@"hud_tips" status:status hideAfterDelay:delay completion:completion];
    
}
#pragma mark - 自定义图片和文字
+ (void)customizeImageName:(NSString *)imageName status:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //变更模式
        _hud.mode = MBProgressHUDModeCustomView;
        
        //处理图片
        UIImage *image = [UIImage imageWithContentsOfFile:[_bundle pathForResource:imageName ofType:@"png"]];
        _hud.customView = [[UIImageView alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        _hud.square = YES;
        
        //添加文本
        _hud.label.text = status;
        
        //回调
        _hud.completionBlock = ^{
            
            _hud.mode = MBProgressHUDModeIndeterminate;
            
            completion ? completion() : nil;
        };
        
        [_keyWindow addSubview:_hud];
        
        [_hud showAnimated:YES];
        
    });
    //延迟隐藏
    [self hideAfterDelay:delay];
    
}
#pragma mark - 显示进度
+ (void)showProgress:(CGFloat)progress status:(NSString *)status{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        //环形进度条
        _hud.mode = MBProgressHUDModeAnnularDeterminate;
        
        //添加文本
        _hud.label.text = status;
        
        //进度
        _hud.progress = progress;
        
        //添加到窗口显示
        if (![_hud superview]) {
            
            [_keyWindow addSubview:_hud];
            
            [_hud showAnimated:YES];
        }
    });
    
}

#pragma mark - 隐藏
+ (void)hide{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        _hud.completionBlock = nil;
        _hud.mode = MBProgressHUDModeIndeterminate;
        
        [_hud hideAnimated:YES];
        
    });
    
}
#pragma mark - 延时隐藏
+ (void)hideAfterDelay:(NSTimeInterval)delay{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_hud hideAnimated:YES afterDelay:delay];
        
    });
    
}




/** -------------------------------------------------
 递归获取当前正在显示的控制器
 
 @param rootViewController 根控制器
 @return 当前正在显示的控制器
 */
/*
UIViewController * JZGetCurrentViewControllerFromRootViewController(UIViewController *rootViewController){
    
    UIViewController *currentViewController;
    
    if ([rootViewController presentedViewController]) {
        // 视图是被presented出来的
        currentViewController = JZGetCurrentViewControllerFromRootViewController(rootViewController.presentedViewController);
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentViewController = JZGetCurrentViewControllerFromRootViewController([(UITabBarController *)rootViewController selectedViewController]);
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentViewController = JZGetCurrentViewControllerFromRootViewController([(UINavigationController *)rootViewController visibleViewController]);
        
    } else {
        // 根视图为非导航类
        currentViewController = rootViewController;
    }
    
    return currentViewController;
    
}
*/

@end
