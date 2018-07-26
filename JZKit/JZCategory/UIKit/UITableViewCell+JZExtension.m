//
//  UITableViewCell+JZExtension.m
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import "UITableViewCell+JZExtension.h"

@implementation UITableViewCell (JZExtension)
#pragma mark - UI
- (void)jz_prepareUI{
    
    //UI
    
}
#pragma mark - JZTableViewCellClassProtocol
+ (CGFloat)jz_heightWithModel:(id)model{
    
    return UITableViewAutomaticDimension;
}
+ (CGFloat)jz_height{
    
    return UITableViewAutomaticDimension;
}
+ (NSString *)jz_identifierWithModel:(id)model{
    
    return NSStringFromClass([self class]);
}
+ (NSString *)jz_identifier{
    
    return NSStringFromClass([self class]);
}
#pragma mark -  JZTableViewCellNotificationProtocol
- (void)jz_registerNotification{
    
    //添加通知
    
}
- (void)jz_removeNotification{
    //移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
