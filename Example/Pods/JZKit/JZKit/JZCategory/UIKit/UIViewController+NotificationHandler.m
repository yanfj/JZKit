//
//  UIViewController+NotificationHandler.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "UIViewController+NotificationHandler.h"
#import <JZKit/JZGeneralMacros.h>

NSString * const JZNotificationNetworkConnectSucceed              = @"JZNotificationNetworkConnectSucceed"; //网络连接上
NSString * const JZNotificationNetworkConnectFailed               = @"JZNotificationNetworkConnectFailed "; //网络连接失败
NSString * const JZNotificationUserAccountTokenRevoked            = @"JZNotificationUserAccountTokenRevoked"; //Token失效
NSString * const JZNotificationUserAccountDidLoginFromOtherDevice = @"JZNotificationUserAccountDidLoginFromOtherDevice"; //异地登录

@implementation UIViewController (NotificationHandler)
#pragma mark -  Notification
- (void)jz_registerNotification{
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jz_networkConnectSucceed) name:JZNotificationNetworkConnectSucceed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jz_networkConnectFailed) name:JZNotificationNetworkConnectFailed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jz_tokenRevoked) name:JZNotificationUserAccountTokenRevoked object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jz_didLoginFromOtherDevice) name:JZNotificationUserAccountDidLoginFromOtherDevice object:nil];
    
    
}
- (void)jz_removeNotification{
    
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
#pragma mark - 网络连接
- (void)jz_networkConnectSucceed{
    
    NSLog(@"网络已连接");
    if ([self respondsToSelector:@selector(jz_actionWhenNetworkConnectSucceed)]) {
        [self jz_actionWhenNetworkConnectSucceed];
    }
}
- (void)jz_networkConnectFailed{
    
    NSLog(@"网络未连接");
    if ([self respondsToSelector:@selector(jz_actionWhenNetworkConnectFailed)]) {
        [self jz_actionWhenNetworkConnectFailed];
    }
}
#pragma mark -  令牌失效
- (void)jz_tokenRevoked{
    //判断是否正在显示
    if (self.isViewLoaded && self.view.window) {
        NSLog(@"令牌已失效");
        if ([self respondsToSelector:@selector(jz_actionWhenUserAccountTokenHasRevoked)]) {
            
            [self jz_actionWhenUserAccountTokenHasRevoked];
        }
        
    }
}
#pragma mark - 异地登录
- (void)jz_didLoginFromOtherDevice{
    
    //判断是否正在显示
    if (self.isViewLoaded && self.view.window) {
        NSLog(@"账号异地登录");
        if ([self respondsToSelector:@selector(jz_actionWhenUserAccountDidLoginFromOtherDevice)]) {
            
            [self jz_actionWhenUserAccountDidLoginFromOtherDevice];
        }
        
    }
}
@end
