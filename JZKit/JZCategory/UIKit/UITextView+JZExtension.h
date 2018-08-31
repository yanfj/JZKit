//
//  UITextView+JZExtension.h
//  AFNetworking
//
//  Created by RRTV-YFJ on 2018/8/31.
//

#import <UIKit/UIKit.h>

@interface UITextView (JZExtension)
/**
 设置长度限制,会自动截取到最大长度，已经处理Emoji的特殊情况
 
 @param maxLength 最大长度
 */
- (void)jz_subTextToMaxLength:(NSInteger)maxLength;

@end
