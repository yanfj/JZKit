//
//  NSString+JZExtension.h
//  Pods-JZKit_Example
//
//  Created by Yan's on 2018/4/26.
//

#import <Foundation/Foundation.h>

/**
 延展
 */
@interface NSString (JZExtension)
/**
 检查去除空格和换行是否不为空

 @return 布尔值
 */
- (BOOL)jz_checkNotNullExceptWhitespaceAndNewline;
/**
 RSA加密
 
 @param pubKey 公钥
 */
- (NSString *)jz_rsaEncryptionWithPublicKey:(NSString *)pubKey;
/**
 参数排序

 @param paramters 参数字典
 @return 排序字符串
 */
- (NSString *)jz_sortParameters:(NSDictionary *)paramters;

/**
 过滤html标签

 @return 过滤字符串
 */
- (NSString *)jz_filterHTMLTags;



@end
