//
//  JZNetworkService.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZNetworkService.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <MJExtension-Enhanced/MJExtension.h>
#import <JZKit/JZGeneralMacros.h>
#import "JZHTTPResponseSerializer.h"
#import "JZNetworkConfiguration.h"
#import "JZNetworkCache.h"
#import "JZBasicRequest.h"
#import "JZBasicResponce.h"


static NSString * const class_request = @"Request";
static NSString * const class_responce = @"Responce";

//AFN大爷
static AFHTTPSessionManager *_sessionManager;
static NSMutableDictionary<NSString *,NSURLSessionDataTask *> *_requestContainer;

@implementation JZNetworkService
#pragma mark - 请求设置
+ (void)initialize{
    
    //请求管理者
    _sessionManager = [AFHTTPSessionManager manager];
    // 设置请求的超时时间(默认15秒)
    _sessionManager.requestSerializer.timeoutInterval = 15.f;
    //设置默认值
    _sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _sessionManager.responseSerializer = [JZHTTPResponseSerializer serializer];
    // 打开状态栏的等待菊花
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    //请求池
    if (_requestContainer == nil) {
        _requestContainer = [NSMutableDictionary dictionary];
    }
}
#pragma mark - 重置AFHTTPSessionManager相关属性
+ (void)setRequestSerializer:(JZRequestSerializer)requestSerializer{
    
    _sessionManager.requestSerializer = (requestSerializer == CPRequestSerializerHTTP) ? [AFHTTPRequestSerializer serializer] : [AFJSONRequestSerializer serializer];
}

+ (void)setResponseSerializer:(JZResponseSerializer)responseSerializer{
    
    _sessionManager.responseSerializer = (responseSerializer == JZResponseSerializerHTTP) ? [JZHTTPResponseSerializer serializer] : [AFJSONResponseSerializer serializer];
}
+ (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    
    _sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
    
}
+ (void)openNetworkActivityIndicator:(BOOL)open{
    
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:open];
}

#pragma mark - 默认从网络请求
+ (void)fetchDataWithRequest:(JZBasicRequest *)request
                  completion:( void (^)(id responseObject, NSError *error))completion{
    
    [self fetchDataWithRequest:request
                       operate:JZHTTPDataOperate_LoadFromRemote
                    completion:completion];
}
#pragma mark -  通过请求获取数据(可操作模式)
+ (void)fetchDataWithRequest:(JZBasicRequest *)request
                     operate:(JZHTTPDataOperate)operate
                  completion:( void (^)(id responseObject, NSError *error))completion{
    
    //获得响应类
    Class responseClass = JZGetResponseClass(request);
    
    //如果从本地读取
    if ((operate & JZHTTPDataOperate_LoadFromLocal) == JZHTTPDataOperate_LoadFromLocal) {
        //从本地读取
        id responseData = [JZNetworkCache cacheForUniqueKey:[request uniqueKey]];
        //如果有数据
        if (responseData != nil) {
            //格式化
            NSDictionary *dict = JZDictFromResponseObject(responseData);
            //转化为对应的响应类
            JZBasicResponce* response = [responseClass mj_objectWithKeyValues:dict];
            //回调
            completion(response , nil );
            
            return;
        }
    }
    //如果请求已经存在,立即取消,发送新的请求
    if ([_requestContainer objectForKey:[request uniqueKey]]) {
        
        //如果不允许重复请求
        if (![request allowRepeat]) {
            //取消请求
            [self cancelRequest:[request uniqueKey]];
        }
    }
    //从网络获取
    if ((operate & JZHTTPDataOperate_LoadFromRemote) == JZHTTPDataOperate_LoadFromRemote) {
        
        void (^completionHandle)(id responseData, NSError * err) = ^(id responseData, NSError* err) {
            //如果缓存到本地
            if (err == nil && (operate & JZHTTPDataOperate_UpdataToLocal) == JZHTTPDataOperate_UpdataToLocal) {
                //存到本地
                [JZNetworkCache setCache:responseData uniqueKey:[request uniqueKey]];
                
            }
            //响应字典
            NSDictionary *dict = nil;
            //是否是取消
            if (err.code != JZHTTPResponseCodeCancel) {
                
                dict = JZDictFromResponseObject(responseData);
                
            } else{
                //创建取消响应
                dict = @{@"code":@(JZHTTPResponseCodeCancel),
                         @"msg":[NSString stringWithFormat:@"请求已取消: %@%@",[request moduleName],[request functionName]]};
                
            }
            //转化为对应的响应类
            JZBasicResponce* response = [responseClass mj_objectWithKeyValues:dict];
            //回调
            completion(response, err);
            //从请求池中移除
            [_requestContainer  removeObjectForKey:[request uniqueKey]];
        };
        
        //拼接URL
        NSString *url = [NSString stringWithFormat:@"%@%@%@", [JZNetworkConfiguration defaultConfiguration].host,[request moduleName],[request functionName]];
        //请求任务
        NSURLSessionDataTask *task = nil;
        //请求
        if ([[request method] isEqualToString:POST]) {
            //POST
            task = [_sessionManager POST:url
                              parameters:[request parameters]
                                progress:nil
                                 success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
                                     //成功回调
                                     if (![JZNetworkConfiguration defaultConfiguration].disabledLog) {
                                         NSLog(@"[POST]--[%@] 🍏\n%@",[request functionName],responseObject);
                                     }
                                     completionHandle( responseObject, nil );
                                 } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                     //失败回调
                                     if (![JZNetworkConfiguration defaultConfiguration].disabledLog) {
                                         NSLog(@"[POST]--[%@] 🍎\n%@",[request functionName],error);
                                     }
                                     completionHandle( [[error userInfo] valueForKey:responce_data], error);
                                 }];
        } else if ([[request method] isEqualToString:GET]){
            //Get
            task = [_sessionManager GET:url
                             parameters:[request parameters]
                               progress:nil
                                success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
                                    //成功回调
                                    if (![JZNetworkConfiguration defaultConfiguration].disabledLog) {
                                        NSLog(@"[GET]--[%@] 🍏\n%@",[request functionName],responseObject);
                                    }
                                    completionHandle( responseObject, nil );
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    //失败回调
                                    if (![JZNetworkConfiguration defaultConfiguration].disabledLog) {
                                        NSLog(@"[GET]--[%@] 🍎\n%@",[request functionName],error);
                                    }
                                    completionHandle( [[error userInfo] valueForKey:responce_data], error);
                                    
                                }];
        } else if ([[request method] isEqualToString:PUT]){
            //Put
            task = [_sessionManager PUT:url
                             parameters:[request parameters]
                                success:^(NSURLSessionDataTask * _Nonnull task, id _Nonnull responseObject) {
                                    //成功回调
                                    if (![JZNetworkConfiguration defaultConfiguration].disabledLog) {
                                        NSLog(@"[PUT]--[%@] 🍏\n%@",[request functionName],responseObject);
                                    }
                                    completionHandle( responseObject, nil );
                                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                    //失败回调
                                    if (![JZNetworkConfiguration defaultConfiguration].disabledLog) {
                                        NSLog(@"[PUT]--[%@] 🍎\n%@",[request functionName],error);
                                    }
                                    completionHandle( [[error userInfo] valueForKey:responce_data], error);
                                    
                                }];
            
        }
            
            
        
        //添加进请求池
        task ? [_requestContainer  setObject:task forKey:[request uniqueKey]] : nil ;
        
    }
}
+ (void)fetchDataWithRequest:(JZBasicRequest *)request
               responseCache:( void (^)(id responseObject))responseCache
                  completion:( void (^)(id responseObject, NSError *error))completion{
    
    //获得请求体的类名
    NSString* requestClassString = NSStringFromClass([request class]);
    //获得响应提的类名
    NSString* responseClassString = [requestClassString stringByReplacingOccurrencesOfString:class_request
                                                                                  withString:class_responce];
    //获得响应类
    Class responseClass = NSClassFromString(responseClassString);
    //读取缓存
    id responseData = [JZNetworkCache cacheForUniqueKey:[request uniqueKey]];
    //响应体
    JZBasicResponce* response = nil;
    //格式化响应数据
    if (responseData != nil) {
        //格式化成字典
        NSDictionary *dict = JZDictFromResponseObject(responseData);
        //获取响应体
        response = [responseClass mj_objectWithKeyValues:dict];
    }
    //回调
    responseCache ? responseCache(response) : nil;
    //从网络获取，然后更新本地数据
    [self fetchDataWithRequest:request operate:(JZHTTPDataOperate_LoadFromRemote|JZHTTPDataOperate_UpdataToLocal) completion:completion];
    
}
#pragma mark - 取消请求
+ (void)cancelRequests:(NSArray<NSString *> *)uniqueKeys{
    
    if (uniqueKeys.count == 0) {
        
        return;
    }
    
    @synchronized (self) {
        
        [uniqueKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull uniqueKey, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([_requestContainer objectForKey:uniqueKey]) {
                //获取请求任务
                NSURLSessionDataTask *task = [_requestContainer  objectForKey:uniqueKey];
                //取消
                [task cancel];
                //取消掉立即清除
                [_requestContainer  removeObjectForKey:uniqueKey];
                
            }
            
        }];
    }
}
+ (void)cancelRequest:(NSString *)uniqueKey{
    
    [self cancelRequests:@[uniqueKey]];
    
}
+ (void)cancelAllRequests{
    
    // 锁操作
    @synchronized(self){
        
        [_requestContainer.allValues makeObjectsPerformSelector:@selector(cancel)];
        
        [_requestContainer removeAllObjects];
    }
    
}
#pragma mark - 格式化响应数据
NSDictionary* JZDictFromResponseObject(id responseObject){
    
    NSData* responseData = nil;
    
    if ([responseObject isKindOfClass:[NSData class]]) {
        
        responseData = responseObject;
        
    }else if ([responseObject isKindOfClass:[NSString class]]) {
        
        responseData = [responseObject dataUsingEncoding:NSUTF8StringEncoding];
        
    }else if([responseObject isKindOfClass:[NSDictionary class]]) {
        
        return responseObject;
        
    } else{
        
        return @{
                 @"code":@(JZHTTPResponseCodeUnkonw),
                 @"msg":@"接收数据格式不正确"
                 };
    }
    NSError* error;
    
    NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    return dict;
}
#pragma mark -  获取响应类名
Class JZGetResponseClass (JZBasicRequest *request){
    
    //获得请求体的类名
    NSString* requestClassString = NSStringFromClass([request class]);
    //获得响应提的类名
    NSString* responseClassString = [requestClassString stringByReplacingOccurrencesOfString:class_request withString:class_responce];
    //获得响应类
    Class responseClass = NSClassFromString(responseClassString);
    
    return responseClass;
    
}
@end

NSString * const JZNotificationNetworkStatusUnknown      = @"JZNotificationNetworkStatusUnknown";       //未知网络
NSString * const JZNotificationNetworkStatusNotReachable = @"JZNotificationNetworkStatusNotReachable";  //无网络
NSString * const JZNotificationNetworkStatusViaWWAN      = @"JZNotificationNetworkStatusViaWWAN";       //蜂窝网络
NSString * const JZNotificationNetworkStatusViaWiFi      = @"JZNotificationNetworkStatusViaWiFi";       //WIFI

@implementation JZNetworkService (NetworkStatus)
#pragma mark - 开始监听网络
+ (void)startNetworkStatusWithBlock:(void(^)(JZNetworkStatus status))networkStatus{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AFNetworkReachabilityManager *reachabilityManager = [AFNetworkReachabilityManager sharedManager];
        [reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status){
                case AFNetworkReachabilityStatusUnknown:{
                    networkStatus ? networkStatus(JZNetworkStatusUnknown) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:JZNotificationNetworkStatusUnknown object:nil];
                    NSLog(@"未知网络");
                }
                    break;
                case AFNetworkReachabilityStatusNotReachable:{
                    networkStatus ? networkStatus(JZNetworkStatusNotReachable) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:JZNotificationNetworkStatusNotReachable object:nil];
                    NSLog(@"无网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:{
                    networkStatus ? networkStatus(JZNetworkStatusViaWWAN) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:JZNotificationNetworkStatusViaWWAN object:nil];
                    NSLog(@"蜂窝网络");
                }
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:{
                    networkStatus ? networkStatus(JZNetworkStatusViaWiFi) : nil;
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:JZNotificationNetworkStatusViaWiFi object:nil];
                    NSLog(@"WIFI");
                }
                    break;
            }
        }];
        
        [reachabilityManager startMonitoring];
    });
}
#pragma mark - 是否有网
+ (BOOL)isReachable{
    
    return [AFNetworkReachabilityManager sharedManager].reachable;
    
}
#pragma mark - 是否是蜂窝网络
+ (BOOL)isWWANNetwork{
    
    return [AFNetworkReachabilityManager sharedManager].reachableViaWWAN;
    
}
#pragma mark - 是否是WIFI
+ (BOOL)isWiFiNetwork{
    
    return [AFNetworkReachabilityManager sharedManager].reachableViaWiFi;
    
}



@end
