//
//  JZDatePicker.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import "JZBasicPicker.h"


@class JZDatePicker;

/**
 时间选择协议
 */
@protocol JZDatePickerProtocol <NSObject>
/**
 选择时间
 
 @param picker 选择器
 @param date 模型
 */
- (void)jz_datePicker:(JZDatePicker *)picker didSelectedDate:(NSDate *)date;

@optional

/**
 取消选择时间
 
 @param picker 选择器
 */
- (void)jz_canceledInDatePicker:(JZDatePicker *)picker;


@end



/**
 时间选择器
 */
@interface JZDatePicker : JZBasicPicker
/**
 *  代理
 */
@property (nonatomic, weak) id<JZDatePickerProtocol> delegate;
/**
 初始化方法
 
 @param mode 时间模式
 @return 实例
 */
- (instancetype)initWithDateMode:(UIDatePickerMode)mode;
/**
 设置时间选择范围
 
 @param maxDate 最大时间
 @param minDate 最小时间
 */
- (void)setMaximumDate:(NSDate *)maxDate andMinimumDate:(NSDate *)minDate;

#pragma mark - 禁用的初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
@end
