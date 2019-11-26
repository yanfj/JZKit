//
//  JZGeographicService.h
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import <JZKit/JZBasicInstance.h>
#import "JZGeographicModel.h"

/**
 地理(省市区)服务
 */
@interface JZGeographicService : JZBasicInstance
/**
 *  数据源(省列表)
 */
@property (nonatomic,copy,readonly) NSArray<id<JZGeographicModel>> *dataSource;
/**
 更新本地的地区数据
 
 @param data 数据
 @param key  键值
 */
- (void)updateGeographicData:(id)data forKey:(NSString *)key;
/**
 读取本地的地区数据
 
 @param key 键值
 @param class 行政省类
 */
- (void)readGeographicDataWithKey:(NSString *)key forClass:(Class)class;
/**
 通过编码搜索名字
 
 @param code 编码
 */
- (NSString *)searchGeographicNameWithCode:(NSInteger)code;
@end
