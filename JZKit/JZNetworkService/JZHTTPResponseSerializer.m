//
//  JZHTTPResponseSerializer.m
//  AFNetworking
//
//  Created by Yan's on 2018/4/27.
//

#import "JZHTTPResponseSerializer.h"

@implementation JZHTTPResponseSerializer
#pragma mark - 重写基类方法，如果服务器返回错误代码，且带有业务数据体，则将数据体添加到错误对象中
- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error {
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (*error != nil && data != nil) {
            NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithDictionary:[*error userInfo]];
            [userInfo setObject:data forKey:responce_data];
            *error = [NSError errorWithDomain:(*error).domain code:(*error).code userInfo:userInfo];
        }
        
        return data;
    }
    
    return ([super responseObjectForResponse:response data:data error:error]);
}
@end
