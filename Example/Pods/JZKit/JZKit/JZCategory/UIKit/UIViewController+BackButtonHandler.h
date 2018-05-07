//
//  UIViewController+BackButtonHandler.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>


/**
 * 返回按钮拦截协议
 */
@protocol JZBackButtonHandlerProtocol <NSObject>
@optional
/**
 重写可以改变返回按钮的执行方法
 
 @return NO
 */
- (BOOL)jz_navigationShouldPopOnBackButton;
@end

/**
 * 拦截导航栏返回按钮方法
 */
@interface UIViewController (BackButtonHandler)<JZBackButtonHandlerProtocol>

@end
