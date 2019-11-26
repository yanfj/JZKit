//
//  UIImage+JZExtension.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "UIImage+JZExtension.h"

@implementation UIImage (JZExtension)
- (void)jz_imageWithSize:(CGSize)aSize radius:(CGFloat)aRadius fillColor:(UIColor *)aColor opaque:(BOOL)opaque completion:(void (^)(UIImage *image))completion{
    
    //GCD
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //利用绘图，建立上下文 设置是否不透明
        UIGraphicsBeginImageContextWithOptions(aSize, opaque, 0);
        //设置尺寸
        CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
        //设置填充颜色
        if (opaque) {
            [aColor setFill];
            UIRectFill(rect);
        }
        //判断是原型还是圆角矩形,利用贝塞尔路径制作裁剪效果
        UIBezierPath *path;
        if ((aSize.width == aSize.height) && (aRadius == aSize.width/2.f)) {
            //如果是圆形
            path = [UIBezierPath bezierPathWithOvalInRect:rect];
            
        }else{
            //如果是矩形
            path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:aRadius];
        }
        [path addClip];
        //绘制图像
        self ? [self drawInRect:rect] : nil;
        //取得效果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        //关闭上下文
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //回调
            completion ? completion(result):nil;
            
        });
    });
}
- (void)jz_imageWithSize:(CGSize)aSize radius:(CGFloat)aRadius completion:(void (^)(UIImage *))completion{
    
    [self jz_imageWithSize:aSize radius:aRadius fillColor:nil opaque:NO completion:completion];
}
@end
