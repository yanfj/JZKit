//
//  JZHTTPResponseSerializer.h
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "AFURLResponseSerialization.h"


static NSString * const response_data = @"response_data";
/**
 *  扩展自AFHTTPResponseSerializer，用来处理AFNetworking处理服务器statecode=500错误时不将数据体传回的问题
 */
@interface JZHTTPResponseSerializer : AFHTTPResponseSerializer

@end
