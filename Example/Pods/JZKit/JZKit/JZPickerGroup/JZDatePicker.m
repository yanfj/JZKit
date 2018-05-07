//
//  JZDatePicker.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZDatePicker.h"

@interface JZDatePicker()
/**
 *  时间选择器
 */
@property (nonatomic, strong) UIDatePicker *picker;
/**
 *  时间
 */
@property (nonatomic, strong) NSDate *date;

@end

@implementation JZDatePicker
#pragma mark - Init
- (instancetype)initWithDateMode:(UIDatePickerMode)mode{
    
    if (self = [super init]) {
        
        //选择器
        self.picker = [[UIDatePicker alloc] init];
        [self.picker setLocale:[NSLocale currentLocale]];
        // 设置时区
        [self.picker setTimeZone:[NSTimeZone localTimeZone]];
        // 设置当前时间
        [self.picker setDate:[NSDate date] animated:YES];
        [self.picker setDatePickerMode:mode];
        [self.picker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:self.picker];
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self.contentView);
        }];
        
        //设置默认时间
        [self dateChanged:self.picker];
        
    }
    
    return self;
    
}
#pragma mark - Utils
- (void)setMaximumDate:(NSDate *)maxDate andMinimumDate:(NSDate *)minDate{
    
    self.picker.minimumDate = minDate;
    self.picker.maximumDate = maxDate;
    
}
#pragma mark - KVO
- (void)dateChanged:(UIDatePicker *)datePicker{
    
    self.date  = datePicker.date;
    
}
#pragma mark - JZBasicPickerProtocol
- (void)jz_actionWhenConfirmButtonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jz_datePicker:didSelectedDate:)]) {
        
        [self.delegate jz_datePicker:self didSelectedDate:self.date];
        
    }
    
}
- (void)jz_actionWhenCancelButtonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jz_canceledInDatePicker:)]) {
        
        [self.delegate jz_canceledInDatePicker:self];
        
    }
}

@end
