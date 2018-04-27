//
//  UIViewController+KeyboardAutoHidden.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

/**
 键盘相关协议
 */
@protocol JZKeyboardAutoHiddenProtocol<NSObject>
@optional
/**
 键盘即将弹出
 
 @param notification 通知
 */
- (void)jz_keyboardWillShow:(NSNotification *)notification;
/**
 键盘即将消失
 
 @param notification 通知
 */
- (void)jz_keyboardWillDismiss:(NSNotification *)notification;

@end

/**
 键盘自动回收
 */
@interface UIViewController (KeyboardAutoHidden)<JZKeyboardAutoHiddenProtocol,UITextFieldDelegate>
/**
 设置键盘自动回收
 */
- (void)jz_setKeyboardAutoHidden;

@end
