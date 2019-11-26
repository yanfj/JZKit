//
//  JZGeographicPicker.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import "JZBasicPicker.h"
#import <JZKit/JZGeographicModel.h>

/**
 选择模式
 
 - JZGeographicModeAccurateToCity: 精确到市(二级联动)
 - JZGeographicModeAccurateToDistrict: 精确到区(三级联动)
 */
typedef NS_ENUM(NSUInteger,JZGeographicMode){
    
    JZGeographicModeAccurateToCity = 2,
    JZGeographicModeAccurateToDistrict = 3,
    
};

@class JZGeographicPicker;

/**
 地区选择协议
 */
@protocol JZGeographicPickerProtocol <NSObject>
/**
 选择地区
 
 @param picker 选择器
 @param model 模型
 */
- (void)jz_geographicPicker:(JZGeographicPicker *)picker didSelectedModel:(id<JZGeographicModel>)model;

@optional

/**
 取消选择地区
 
 @param picker 选择器
 */
- (void)jz_canceledInGeographicPicker:(JZGeographicPicker *)picker;

@end

/**
 地区选择器
 */
@interface JZGeographicPicker : JZBasicPicker
/**
 *  代理
 */
@property (nonatomic, weak) id<JZGeographicPickerProtocol> delegate;
/**
 初始化方法
 
 @param mode 模式
 @param key  键值
 @param class 省类名
 */
- (instancetype)initWithMode:(JZGeographicMode)mode andKey:(NSString *)key forClass:(Class)class;

#pragma mark - 禁用的初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
