//
//  UITableViewCell+JZExtension.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

#pragma mark - 类方法协议
@protocol JZTableViewCellClassProtocol <NSObject>
@optional
/**
 根据模型返回重用标识符
 
 @param model 模型
 @return 重用标识符
 */
+ (NSString *)jz_identifierWithModel:(id)model;
/**
 单一的重用标识符
 
 @return 重用标识符
 */
+ (NSString *)jz_identifier;
/**
 根据模型返回单元格高度
 
 @param model 模型
 @return 高度
 */
+ (CGFloat)jz_heightWithModel:(id)model;
/**
 单元格高度（定高）
 
 @return 高度
 */
+ (CGFloat)jz_height;

@end

#pragma mark - 通知协议
@protocol JZTableViewCellNotificationProtocol <NSObject>
@optional
/**
 *   注册通知
 */
- (void)jz_registerNotification;
/**
 *   移除通知
 */
- (void)jz_removeNotification;

@end

#pragma mark - 延展
@interface UITableViewCell (JZExtension)<JZTableViewCellClassProtocol,JZTableViewCellNotificationProtocol>
/**
 配置UI
 */
- (void)jz_prepareUI;

@end
