//
//  JZGeneralPicker.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import "JZBasicPicker.h"

/**
 选择器模型协议
 */
@protocol JZGeneralModel <NSObject>
/**
 *  ID
 */
@property (nonatomic, assign) NSInteger generalID;
/**
 *  名称
 */
@property (nonatomic, copy) NSString *generalDescription;

@end


@class JZGeneralPicker;

/**
 模型选择协议
 */
@protocol JZGeneralPickerProtocol <NSObject>
/**
 选择模型
 
 @param picker 选择器
 @param model 模型
 */
- (void)jz_generalPicker:(JZGeneralPicker *)picker didSelectedModel:(id<JZGeneralModel>)model;

@optional

/**
 取消选择模型
 
 @param picker 选择器
 */
- (void)jz_canceledInGeneralPicker:(JZGeneralPicker *)picker;

@end



/**
 模型选择器
 */
@interface JZGeneralPicker : JZBasicPicker
/**
 *  代理
 */
@property (nonatomic, weak) id<JZGeneralPickerProtocol> delegate;

/**
 初始化方法
 
 @param dataSource 数据源
 @return 实例
 */
- (instancetype)initWtihDataSource:(NSArray<id<JZGeneralModel>> *)dataSource;

#pragma mark - 禁用的初始化方法
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end
