//
//  JZGeographicPicker.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZGeographicPicker.h"
#import <JZKit/NSArray+JZExtension.h>
#import <JZKit/JZGeneralMacros.h>
#import <JZKit/JZGeographicService.h>

/**
 选择列
 
 - JZComponentProvince: 省
 - JZComponentCity:     市
 - JZComponentDistrict: 区
 */
typedef NS_ENUM(NSInteger,JZComponent){
    
    JZComponentProvince = 0,
    JZComponentCity     = 1,
    JZComponentDistrict = 2,
    
};

@interface JZGeographicPicker()<UIPickerViewDelegate,UIPickerViewDataSource>
/**
 *  模式
 */
@property (nonatomic, assign) JZGeographicMode geoMode;
/**
 *  选择器
 */
@property (nonatomic, strong) UIPickerView *picker;
/**
 *  省列表
 */
@property (nonatomic, copy) NSArray<id<JZGeographicModel>> *provinceList;
/**
 *  市列表
 */
@property (nonatomic, copy) NSArray<id<JZGeographicModel>> *cityList;
/**
 *  区列表
 */
@property (nonatomic, copy) NSArray<id<JZGeographicModel>> *districtList;
/**
 *  选中的模型
 */
@property (nonatomic, strong) id<JZGeographicModel> model;
/**
 *  当前选中的省名
 */
@property (nonatomic, copy) NSString *provinceName;
/**
 *  当前选中的市名
 */
@property (nonatomic, copy) NSString *cityName;
/**
 *  省类名
 */
@property (nonatomic, strong) Class class;

@end

@implementation JZGeographicPicker

#pragma mark - Life Cycle
- (instancetype)initWithMode:(JZGeographicMode)mode andKey:(NSString *)key forClass:(Class)class{
    
    if (self = [super init]) {
        
        self.geoMode = mode;
        self.class = class;
        
        //读取数据
        [[JZGeographicService sharedInstance] readGeographicDataWithKey:key forClass:class];
        self.provinceList = [JZGeographicService sharedInstance].dataSource;
        self.cityList = [self checkCityListNullAtRow:0];
        self.model = [self.cityList firstObject];
        
        //当前的省名和市名
        self.provinceName = [self.provinceList firstObject].name;
        self.cityName = [self.cityList firstObject].name;
        
        if (self.geoMode == JZGeographicModeAccurateToDistrict) {
            self.districtList = [self checkDistrictListNullAtRow:0];
            self.model = [self.districtList firstObject];
        }
        
        
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
    
    return self.geoMode;
    
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    switch (component) {
            case JZComponentProvince:
            return self.provinceList.count;
            break;
            case JZComponentCity:
            return self.cityList.count;
            break;
            case JZComponentDistrict:
            return self.districtList.count;
            break;
        default:
            return 0;
            break;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return UI_SCALE(40);
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = (UILabel *)view;
    if (!label) {
        
        label = [self labelForPicker];
        
    }
    label.text = [self titleForComponent:component row:row];
    
    //设置横线的颜色，实现显示或者隐藏
    [pickerView.subviews objectAtIndex:1].backgroundColor = [JZBasicPickerConfiguration globalConfiguration].separateLineColor;
    [pickerView.subviews objectAtIndex:2].backgroundColor = [JZBasicPickerConfiguration globalConfiguration].separateLineColor;
    
    return label;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == JZComponentProvince) {
        
        self.cityList = [self checkCityListNullAtRow:row];
        
        [pickerView reloadComponent:JZComponentCity];
        [pickerView selectRow:0 inComponent:JZComponentCity animated:YES];
        
        self.model = [self.cityList firstObject];
        //省名和市名
        self.provinceName = self.provinceList[row].name;
        self.cityName = [self.cityList firstObject].name;
        
        if (self.geoMode == JZGeographicModeAccurateToDistrict) {
            
            self.districtList = [self checkDistrictListNullAtRow:0];
            
            [pickerView reloadComponent:JZComponentDistrict];
            [pickerView selectRow:0 inComponent:JZComponentDistrict animated:YES];
            
            self.model = [self.districtList firstObject];
            
        }
        
    }else if (component == JZComponentCity){
        
        self.model = self.cityList[row];
        //市名
        self.cityName = self.cityList[row].name;
        
        if (self.geoMode == JZGeographicModeAccurateToDistrict) {
            
            self.districtList = [self checkDistrictListNullAtRow:row];
            
            [pickerView reloadComponent:JZComponentDistrict];
            [pickerView selectRow:0 inComponent:JZComponentDistrict animated:YES];
            
            self.model = [self.districtList firstObject];
            
        }
        
    }else{
        
        self.model = [self.districtList objectAtIndex:row];
    }
    
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
- (NSString *)titleForComponent:(NSInteger)component row:(NSInteger)row{
    
    switch (component) {
            case JZComponentProvince:
            return [self.provinceList jz_checkNotNullAtIndex:row]?[self.provinceList objectAtIndex:row].name :EMPTY_STRING;
            break;
            case JZComponentCity:
            return [self.cityList jz_checkNotNullAtIndex:row]?[self.cityList objectAtIndex:row].name:EMPTY_STRING;
            break;
            case JZComponentDistrict:
            return [self.districtList jz_checkNotNullAtIndex:row]?[self.districtList objectAtIndex:row].name:EMPTY_STRING;
            break;
        default:
            return EMPTY_STRING;
            break;
    }
    
}
#pragma mark - Utils
- (NSArray<id<JZGeographicModel>> *)checkCityListNullAtRow:(NSInteger)row{
    
    
    if ([self.provinceList jz_checkNotNullAtIndex:row]) {
        
        return [self.provinceList objectAtIndex:row].cities;
        
    }else{
        
        return [NSArray array];
    }
    
}
- (NSArray<id<JZGeographicModel>> *)checkDistrictListNullAtRow:(NSInteger)row{
    
    if ([self.cityList jz_checkNotNullAtIndex:row]) {
        
        return [self.cityList objectAtIndex:row].districts;
        
    }else{
        
        return [NSArray array];
    }
    
}
#pragma mark - CPBasicPickerProtocol
- (void)jz_actionWhenConfirmButtonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jz_geographicPicker:didSelectedModel:)]) {
        
        id<JZGeographicModel> model = [[self.class alloc] init];
        model.code = self.model.code;
        //精确到区
        if (self.geoMode == JZGeographicModeAccurateToDistrict) {
            
            NSInteger code = self.model.code/10000;
            //排除直辖市
            if (code == 11 || code == 12 || code == 31 || code == 50) {
                model.name = [NSString stringWithFormat:@"%@ %@",self.cityName,self.model.name];
            }else{
                model.name = [NSString stringWithFormat:@"%@ %@ %@",self.provinceName,self.cityName,self.model.name];
            }
            
        }else{
            NSInteger code = self.model.code/10000;
            //排除直辖市
            if (code == 11 || code == 12 || code == 31 || code == 50) {
                
                model.name = self.model.name;
                
            }else{
                
                model.name = [NSString stringWithFormat:@"%@ %@",self.provinceName,self.cityName];
            }
            
        }
        
        [self.delegate jz_geographicPicker:self didSelectedModel:model];
    }
    
    
}
- (void)jz_actionWhenCancelButtonClicked{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(jz_canceledInGeographicPicker:)]) {
        
        [self.delegate jz_canceledInGeographicPicker:self];
    }
}

@end
