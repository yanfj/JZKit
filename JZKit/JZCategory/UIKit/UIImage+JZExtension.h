//
//  UIImage+JZExtension.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

@interface UIImage (JZExtension)
/**
 设置圆角图片
 
 @param aSize 尺寸
 @param aRadius 圆角
 @param aColor 颜色
 @param opaque 是否不透明
 @param completion 回调
 */
- (void)jz_imageWithSize:(CGSize)aSize radius:(CGFloat)aRadius fillColor:(UIColor *)aColor opaque:(BOOL)opaque completion:(void (^)(UIImage *image))completion;
/**
 设置圆角图片

 @param aSize 尺寸
 @param aRadius 圆角
 @param completion 回调
 */
- (void)jz_imageWithSize:(CGSize)aSize radius:(CGFloat)aRadius completion:(void (^)(UIImage *))completion;
@end
