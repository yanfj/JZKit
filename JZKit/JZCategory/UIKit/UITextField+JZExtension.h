//
//  UITextField+JZExtension.h
//  JZKit
//
//  Created by Yan's on 2018/8/31.
//

#import <UIKit/UIKit.h>

@interface UITextField (JZExtension)
/**
 设置长度限制,会自动截取到最大长度，已经处理Emoji的特殊情况

 @param maxLength 最大长度
 */
- (void)jz_subTextToMaxLength:(NSInteger)maxLength;

@end
