//
//  UICollectionViewCell+JZExtension.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

#pragma mark - 类方法协议
@protocol JZCollectionViewCellClassProtocol <NSObject>
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
 根据模型返回单元格尺寸
 
 @param model 模型
 @return 尺寸
 */
+ (CGSize)jz_itemSizeWithModel:(id)model;
/**
 单元格高度（定高）
 
 @return 尺寸
 */
+ (CGSize)jz_itemSize;

@end

#pragma mark - 通知协议
@protocol JZCollectionViewCellNotificationProtocol <NSObject>
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

@interface UICollectionViewCell (JZExtension)<JZCollectionViewCellClassProtocol,JZCollectionViewCellNotificationProtocol>
/**
 配置UI
 */
- (void)jz_prepareUI NS_REQUIRES_SUPER;

@end
