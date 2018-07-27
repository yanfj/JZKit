//
//  UIButton+JZExtension.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "UIButton+JZExtension.h"
#import "UIImage+JZExtension.h"
#import <SDWebImage/UIButton+WebCache.h>

@implementation UIButton (JZExtension)
#pragma mark - 调整水平距离(图左文右)
- (void)jz_adjustHorizontalLayoutWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.image.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize titleSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    CGFloat totalWidth = (titleSize.width + space + imageSize.width);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, totalWidth, MAX(imageSize.height, textSize.height));
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - imageSize.width, 0, imageSize.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleSize.width + space, 0, - (titleSize.width + space))];
}
#pragma mark - 调整竖直距离(图上文下)
- (void)jz_adjustVerticalLayoutWithSpace:(CGFloat)space{
    
    CGSize imageSize = self.imageView.image.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize titleSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    CGFloat totalHeight = (imageSize.height + titleSize.height + space);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, MAX(imageSize.width, textSize.width), totalHeight);
    [self setImageEdgeInsets:UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0, 0, - titleSize.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0)];
    
}
#pragma mark - 异步加载圆角图片
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage fillColor:(UIColor *)aColor radius:(CGFloat)aRadius forState:(UIControlState)state{
    
    [self jz_setImageWithURLString:aURLString placeholder:aImage fillColor:aColor opaque:YES radius:aRadius forState:state];
    
}
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage radius:(CGFloat)aRadius forState:(UIControlState)state{
    
    [self jz_setImageWithURLString:aURLString placeholder:aImage fillColor:nil opaque:NO radius:aRadius forState:state];
    
}
- (void)jz_setImageWithURLString:(NSString *)aURLString placeholder:(UIImage *)aImage fillColor:(UIColor *)aColor opaque:(BOOL)opaque radius:(CGFloat)aRadius forState:(UIControlState)state{
    
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
            [weakSelf sd_setImageWithURL:url forState:state placeholderImage:radiusPlaceHolder completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                //将下载的图片圆角化
                [image jz_imageWithSize:size radius:aRadius fillColor:aColor opaque:opaque completion:^(UIImage *radiusImage) {
                    
                    
                    [weakSelf setImage:radiusImage forState:state];
                }];
            }];
        }];
        
    }else{
        //占位符为空的情况,使用sd异步加载网络图片
        [self sd_setImageWithURL:url forState:state completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            //将下载的图片圆角化
            [image jz_imageWithSize:size radius:aRadius fillColor:aColor opaque:opaque completion:^(UIImage *radiusImage) {
                
                [weakSelf setImage:radiusImage forState:state];
            }];
        }];
        
    }
    
    
}
@end
