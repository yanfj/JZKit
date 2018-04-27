//
//  JZGeneralPicker.m
//  AFNetworking
//
//  Created by Yan's on 2018/4/27.
//

#import "JZGeneralPicker.h"
#import <JZKit/JZGeneralMacros.h>
#import <JZKit/NSArray+JZExtension.h>

@interface JZGeneralPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
/**
 *  数据源
 */
@property (nonatomic, copy) NSArray<id<JZGeneralModel>> *dataSource;
/**
 *  选择器
 */
@property (nonatomic, strong) UIPickerView *picker;
/**
 *  模型
 */
@property (nonatomic, strong) id<JZGeneralModel> model;

@end


@implementation JZGeneralPicker
#pragma mark - Init
- (instancetype)initWtihDataSource:(NSArray<id<JZGeneralModel>> *)dataSource{
    
    if (self = [super init]) {
        
        self.dataSource = dataSource ? : [NSArray array];
        
        self.model = [self.dataSource jz_checkNotNullAtIndex:0]?[self.dataSource firstObject]:nil;
        
        self.picker = [[UIPickerView alloc] init];
        self.picker.showsSelectionIndicator = YES;
        self.picker.delegate = self;
        self.picker.dataSource = self;
        [self.contentView addSubview:self.picker];
        [self.picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.mas_equalTo(self.contentView);
        }];
        
    }
    
    return self;
}
#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.dataSource.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return UI_SCALE(40);
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        
        label = [self labelForPicker];
        
    }
    label.text = [self titleForRow:row];
    
    //设置横线的颜色，实现显示或者隐藏
    [pickerView.subviews objectAtIndex:1].backgroundColor = [JZBasicPickerConfiguration globalConfiguration].separateLineColor;
    [pickerView.subviews objectAtIndex:2].backgroundColor = [JZBasicPickerConfiguration globalConfiguration].separateLineColor;
    
    return label;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.model = [self.dataSource objectAtIndex:row];
    
}
#pragma mark - UI
- (UILabel *)labelForPicker{
    
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [JZBasicPickerConfiguration globalConfiguration].selectedTextColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    
    return label;
    
}
- (NSString *)titleForRow:(NSInteger)row{
    
    return [self.dataSource jz_checkNotNullAtIndex:row]?[self.dataSource objectAtIndex:row].generalDescription : EMPTY_STRING;
    
}
#pragma mark - JZBasicPickerProtocol
- (void)jz_actionWhenConfirmButtonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jz_generalPicker:didSelectedModel:)]) {
        
        [self.delegate jz_generalPicker:self didSelectedModel:self.model];
        
    }
    
}
- (void)jz_actionWhenCancelButtonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jz_canceledInGeneralPicker:)]) {
        
        [self.delegate jz_canceledInGeneralPicker:self];
        
    }
}



@end
