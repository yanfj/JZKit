//
//  JZProgressHUD.h
//  JZKit
//
//  Created by YAN on 2018/4/28.
//

#import <Foundation/Foundation.h>

/**
 * 回调
 */
typedef void (^JZProgressHUDCompletionBlock)(void);

/**
 HUD
 */
@interface JZProgressHUD : NSObject
/**
 * 显示
 */
+ (void)show;
/**
 * 显示状态
 *
 * @param status 状态
 */
+ (void)showStatus:(NSString *)status;
/**
 * 显示成功(默认1.5s后隐藏)
 *
 * @param status 状态
 * @param completion  回调
 */
+ (void)showSuccessWithStatus:(NSString *)status completion:(JZProgressHUDCompletionBlock)completion;
/**
 * 显示成功(自定义隐藏时间)
 *
 * @param status 状态
 * @param delay  延迟
 * @param completion  回调
 */
+ (void)showSuccessWithStatus:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion;
/**
 * 显示错误(默认1.5s后隐藏)
 *
 * @param status 状态
 * @param completion  回调
 */
+ (void)showErrorWithStatus:(NSString *)status completion:(JZProgressHUDCompletionBlock)completion;

/**
 * 显示错误(自定义隐藏时间)
 *
 * @param status 状态
 * @param delay  延迟
 * @param completion  回调
 */
+ (void)showErrorWithStatus:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion;
/**
 * 提示(默认1.5s后隐藏)
 *
 * @param status 状态
 * @param completion  回调
 */
+ (void)showTipsWithStatus:(NSString *)status completion:(JZProgressHUDCompletionBlock)completion;

/**
 * 提示(自定义隐藏时间)
 *
 * @param status 状态
 * @param delay  延迟
 * @param completion  回调
 */
+ (void)showTipsWithStatus:(NSString *)status hideAfterDelay:(CGFloat)delay completion:(JZProgressHUDCompletionBlock)completion;

/**
 * 显示进度
 *
 * @param progress 进度
 * @param status   状态
 */
+ (void)showProgress:(CGFloat)progress status:(NSString *)status;

/**
 * 隐藏
 */
+ (void)hide;

/**
 * 延迟隐藏
 *
 * @param delay 时间(s)
 */
+ (void)hideAfterDelay:(NSTimeInterval)delay;

@end
