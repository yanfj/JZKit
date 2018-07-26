//
//  UICollectionReusableView+JZExtension.m
//  AFNetworking
//
//  Created by RRTV-YFJ on 2018/7/26.
//

#import "UICollectionReusableView+JZExtension.h"

@implementation UICollectionReusableView (JZExtension)
#pragma mark - UI
- (void)jz_prepareUI{
    
    //UI
    
}
#pragma mark - Class
+ (CGSize)jz_itemSizeWithModel:(id)model{
    
    return CGSizeZero;
}
+ (CGSize)jz_itemSize{
    
    return CGSizeZero;
}
+ (NSString *)jz_identifierWithModel:(id)model{
    
    return NSStringFromClass([self class]);
}
+ (NSString *)jz_identifier{
    
    return NSStringFromClass([self class]);
}
#pragma mark -  Notification
- (void)jz_registerNotification{
    
    //添加通知
}
- (void)jz_removeNotification{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
