//
//  UIViewController+NotificationHandler.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>


UIKIT_EXTERN  NSString *const JZNotificationNetworkConnectSucceed;              //网络连接上
UIKIT_EXTERN  NSString *const JZNotificationNetworkConnectFailed;               //网络连接失败
UIKIT_EXTERN  NSString *const JZNotificationUserAccountTokenRevoked;            //令牌失效
UIKIT_EXTERN  NSString *const JZNotificationUserAccountDidLoginFromOtherDevice; //异地登录


/**
 * 控制器通知处理协议
 */
@protocol JZNotificationHandleProtocol <NSObject>
@optional
/**
 *  用户信息令牌失效
 */
- (void)jz_actionWhenUserAccountTokenHasRevoked;
/**
 *  用户账号异地登录
 */
- (void)jz_actionWhenUserAccountDidLoginFromOtherDevice;
/**
 *  网络恢复连接
 */
- (void)jz_actionWhenNetworkConnectSucceed;
/**
 *  网络断开连接
 */
- (void)jz_actionWhenNetworkConnectFailed;

@end


/**
 常规通知处理
 */
@interface UIViewController (NotificationHandler)<JZNotificationHandleProtocol>
/**
 *  注册通知
 */
- (void)jz_registerNotification NS_REQUIRES_SUPER;
/**
 *  移除通知
 */
- (void)jz_removeNotification NS_REQUIRES_SUPER;

@end
