//
//  UIButton+JZExtension.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

@interface UIButton (JZExtension)
/**
 调整水平距离(图右文左)
 
 @param space 距离
 */
- (void)jz_adjustHorizontalLayoutWithSpace:(CGFloat)space;

/**
 调整竖直距离(图上文下)
 
 @param space 距离
 */
- (void)jz_adjustVerticalLayoutWithSpace:(CGFloat)space;
/**
 异步加载圆角图片（有背景色）
 
 @param aURLString 图片地址字符串
 @param aImage 占位符图片
 @param aColor 填充颜色
 @param aRadius 圆角
 @param state 状态
 */
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage fillColor:(UIColor *)aColor radius:(CGFloat)aRadius forState:(UIControlState)state;
/**
 异步加载圆角图片（无背景色）
 
 @param aURLString 图片地址字符串
 @param aImage 占位符图片
 @param aRadius 圆角
 @param state 状态
 */
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage radius:(CGFloat)aRadius forState:(UIControlState)state;
@end
