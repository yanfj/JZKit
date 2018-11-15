//
//  UITextView+JZExtension.m
//  AFNetworking
//
//  Created by RRTV-YFJ on 2018/8/31.
//

#import "UITextView+JZExtension.h"
#import "NSString+JZExtension.h"

@implementation UITextView (JZExtension)
#pragma mark - 截取最大长度
- (void)jz_subTextToMaxLength:(NSInteger)maxLength{
    //源字符串
    NSString *originString = self.text;
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;    //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) {//中文输入
        //获取高亮部分
        UITextRange *selectedRange = [self markedTextRange];
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        if (!position) {
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (originString.length > maxLength) {
                self.text = [originString jz_substringToIndex:maxLength];
            }
        }else{
            //有高亮选择的字符串，则暂不对文字进行统计和限制
        }
    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (originString.length > maxLength) {
            self.text = [originString jz_substringToIndex:maxLength];
        }
    }
}
@end
