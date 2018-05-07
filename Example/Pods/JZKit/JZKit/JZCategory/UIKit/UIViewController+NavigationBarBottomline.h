//
//  UIViewController+NavigationBarBottomline.h
//  JZKit
//
//  Created by Yan's on 2018/4/26.
//

#import <UIKit/UIKit.h>

/**
 导航栏底线
 */
@interface UIViewController (NavigationBarBottomline)
/**
 *  导航栏底线
 */
@property (nonatomic, strong) UIImageView *jz_bottomline;
/**
 * 查找导航栏底线
 */
- (void)jz_searchBottomline;
@end
