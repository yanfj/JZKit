//
//  UIImageView+JZExtension.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

@interface UIImageView (JZExtension)
/**
 异步加载圆角图片（有背景色）
 
 @param aURLString 图片地址字符串
 @param aImage 占位符图片
 @param aColor 填充颜色
 @param aRadius 圆角
 */
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage fillColor:(UIColor *)aColor radius:(CGFloat)aRadius;
/**
 异步加载圆角图片（无背景色）
 
 @param aURLString 图片地址字符串
 @param aImage 占位符图片
 @param aRadius 圆角
 */
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage radius:(CGFloat)aRadius;
@end
