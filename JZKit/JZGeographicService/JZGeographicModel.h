//
//  JZGeographicModel.h
//  AFNetworking
//
//  Created by Yan's on 2018/4/27.
//

#import <Foundation/Foundation.h>


/**
 地区模型协议
 */
@protocol JZGeographicModel <NSObject>
/**
 *  地区编码
 */
@property (nonatomic, assign) NSInteger code;
/**
 *  名字
 */
@property (nonatomic, copy) NSString *name;
@optional
/**
 *  行政区列表
 */
@property (nonatomic, copy) NSArray<id<JZGeographicModel>> *districts;
/**
 *  行政区列表
 */
@property (nonatomic, copy) NSArray<id<JZGeographicModel>> *cities;
@end
