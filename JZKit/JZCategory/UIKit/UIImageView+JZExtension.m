//
//  UIImageView+JZExtension.m
//  JZKit
//
//  Created by YAN on 2018/4/26.
//

#import "UIImageView+JZExtension.h"
#import "UIImage+JZExtension.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UIImageView (JZExtension)
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage fillColor:(UIColor *)aColor radius:(CGFloat)aRadius{
    
    [self jz_setImageWithURLString:aURLString placeholder:aImage fillColor:aColor opaque:YES radius:aRadius];
    
}
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage radius:(CGFloat)aRadius{
    
    [self jz_setImageWithURLString:aURLString placeholder:aImage fillColor:nil opaque:NO radius:aRadius];
    
}
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage fillColor:(UIColor *)aColor opaque:(BOOL)opaque radius:(CGFloat)aRadius{
    
    [self.superview layoutIfNeeded];
    //地址
    NSURL *url = [NSURL URLWithString:aURLString];
    //防止循环引用
    __weak typeof(self) weakSelf = self;
    //尺寸
    CGSize size = self.frame.size;
    if (aImage) {
        //占位符不为空的情况,先将占位符圆角化
        [aImage jz_imageWithSize:size radius:aRadius fillColor:aColor opaque:opaque completion:^(UIImage *radiusPlaceHolder) {
            
            //使用sd异步加载网络图片
            [weakSelf sd_setImageWithURL:url placeholderImage:radiusPlaceHolder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                //将下载的图片圆角化
                [image jz_imageWithSize:size radius:aRadius fillColor:aColor opaque:opaque completion:^(UIImage *radiusImage) {
                    
                    weakSelf.image = radiusImage;
                }];
                
                
            }];
            
        }];
        
    }else{
        //占位符为空的情况,使用sd异步加载网络图片
        [self sd_setImageWithURL:url completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            //将下载的图片圆角化
            [image jz_imageWithSize:size radius:aRadius fillColor:aColor opaque:opaque completion:^(UIImage *radiusImage) {
                
                weakSelf.image = radiusImage;
            }];
        }];
        
    }
    
    
}
@end
