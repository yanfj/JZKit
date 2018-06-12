//
//  UICollectionViewCell+JZExtension.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "UICollectionViewCell+JZExtension.h"

@implementation UICollectionViewCell (JZExtension)
#pragma mark - UI
- (void)jz_prepareUI{
    
    self.contentView.clipsToBounds = YES;
    
}
#pragma mark - Notification
- (void)jz_registerNotification{
    
    //通知
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
- (void)jz_removeNotification{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}@end
