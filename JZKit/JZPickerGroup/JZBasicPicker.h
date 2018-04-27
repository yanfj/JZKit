//
//  JZBasicPicker.h
//  AFNetworking
//
//  Created by Yan's on 2018/4/27.
//

#import "MMPopupView.h"
#import <Masonry/Masonry.h>

/**
 配置信息
 */
@interface JZBasicPickerConfiguration : NSObject
/**
 *  按钮字体大小
 */
@property (nonatomic, strong) UIFont *textFont; //默认 16
/**
 *  确认字体颜色
 */
@property (nonatomic, strong) UIColor *confirmTextColor; //默认 #4A4A4A
/**
 *  取消字体颜色
 */
@property (nonatomic, strong) UIColor *cancelTextColor; //默认 #4A4A4A
/**
 *  按钮栏背景颜色
 */
@property (nonatomic, strong) UIColor *tintColor; //默认 #F7F6F5
/**
 *  确认文本
 */
@property (nonatomic, copy) NSString *confirmText; //默认确认
/**
 *  取消文本
 */
@property (nonatomic, copy) NSString *cancelText; //默认取消
/**
 *  分割线颜色
 */
@property (nonatomic, strong) UIColor *separateLineColor;  //默认 #E7E7E7
/**
 *  选择器文本颜色
 */
@property (nonatomic, strong) UIColor *selectedTextColor;  //默认 #4A4A4A

/**
 单例
 */
+ (JZBasicPickerConfiguration*) globalConfiguration;

@end

/**
 * 选择视图协议
 */
@protocol JZBasicPickerProtocol <NSObject>
@optional
/**
 确定按钮点击
 */
- (void)jz_actionWhenConfirmButtonClicked;
/**
 取消按钮点击
 */
- (void)jz_actionWhenCancelButtonClicked;

@end

/**
 * 选择视图基类
 */
@interface JZBasicPicker : MMPopupView<JZBasicPickerProtocol>
/**
 * 内容视图
 */
@property (nonatomic, strong , readonly) UIView *contentView;
/**
 *  按钮栏
 */
@property (nonatomic, strong , readonly) UIView *bar;
/**
 *  取消按钮
 */
@property (nonatomic, strong , readonly) UIButton *cancelButton;
/**
 *  确定按钮
 */
@property (nonatomic, strong , readonly) UIButton *confirmButton;
@end
