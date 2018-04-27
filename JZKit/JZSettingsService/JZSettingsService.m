//
//  JZSettingsService.m
//  JZKit
//
//  Created by Yan's on 2018/4/27.
//

#import "JZSettingsService.h"
#import <JZKit/JZGeneralMacros.h>

//跳转到appStore
static NSString * const appStoreSchemes = @"itms-apps://itunes.apple.com/app/";
//appStore信息
static NSString * const appStoreURL = @"http://itunes.apple.com/cn/lookup?";

@implementation JZSettingsService
#pragma mark - 计算单个文件的大小
+ (long long)fileSizeAtPath:(NSString *) filePath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    
    return 0 ;
    
}
#pragma mark - 遍历文件夹获得文件夹大小,返回多少MB
+ (CGFloat)folderSizeAtPath:(NSString *)folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:folderPath]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        
        folderSize += [self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}
#pragma mark - Cache大小
+ (CGFloat)cacheSize{
    
    NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
    
    return [self folderSizeAtPath:cachPath];
    
}
#pragma mark - 清理缓存
+ (void)clearCache{
    
    [self clearCacheWithCompletion:nil];
}
+ (void)clearCacheWithCompletion:(void(^)())completion{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES) firstObject];
        NSArray * files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
        NSLog( @"Cache路径: %@" , cachPath);
        for ( NSString * p in files) {
            NSError * error = nil ;
            NSString * path = [cachPath stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"清理成功");
            completion ? completion() : nil;
        });
    });
}
#pragma mark - 跳转appStore评分
+ (void)toAppStoreGradeWithAppId:(NSString *)appId{
    
    NSString *str = [NSString stringWithFormat:@"%@id%@",appStoreSchemes,appId];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
}
#pragma mark - 监测版本更新
+ (void)checkNewReleasesWithAppId:(NSString *)appId
                completionHandler:(void(^)(NSString *localVersion,NSString *storeVersion,NSString *openUrl,BOOL needUpdate))handler{
    //当前版本号
    __block NSString * localVersion = APP_VERSION;
    NSLog(@"开始检测...");
    NSLog(@"当前版本号: %@",localVersion);
    NSString *urlString;
    if (appId != nil) {
        //通过appid查找
        urlString = [NSString stringWithFormat:@"%@id=%@",appStoreURL,appId];
        NSLog(@"当前通过appId检测  appId: %@",appId);
    }else {
        //通过bundleId查找
        NSString *bundleId = APP_BUNDLE_ID;
        urlString = [NSString stringWithFormat:@"%@bundleId=%@&country=cn",appStoreURL,bundleId];
        NSLog(@"当前通过bundleId检测  bundleId: %@",bundleId);
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSLog(@"请求苹果服务器...");
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"检测失败,原因:\n%@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                handler ? handler(localVersion,EMPTY_STRING,EMPTY_STRING,NO) : nil;
            });
            return;
        }else{
            NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            //如果没查询到
            if ([appInfoDic[@"resultCount"] integerValue] == 0) {
                NSLog(@"检测出未上架的APP或者查询不到");
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler ? handler(localVersion,EMPTY_STRING,EMPTY_STRING,NO) : nil;
                });
                return;
            }
            //商店版本号
            NSString *appStoreVersion = appInfoDic[@"results"][0][@"version"];
            NSString *openURL = appInfoDic[@"results"][0][@"trackViewUrl"];
            NSLog(@"苹果服务器返回的检测结果:\n=========================\nappId : %@ \nbundleId : %@ \n开发账号 : %@ \n商店版本号 : %@ \n应用名称 : %@ \n打开连接 : %@\n=========================",appInfoDic[@"results"][0][@"artistId"],appInfoDic[@"results"][0][@"bundleId"],appInfoDic[@"results"][0][@"artistName"],appStoreVersion,appInfoDic[@"results"][0][@"trackName"],openURL);
            //处理版本号
            localVersion = [localVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            appStoreVersion = [appStoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
            //统一格式
            for (NSInteger idx = MIN(localVersion.length, appStoreVersion.length); idx< MAX(localVersion.length, appStoreVersion.length); idx ++){
                if (localVersion.length < appStoreVersion.length) {
                    localVersion = [localVersion stringByAppendingString:@"0"];
                }else{
                    appStoreVersion = [appStoreVersion stringByAppendingString:@"0"];
                }
            }
            //比较
            if([localVersion floatValue] < [appStoreVersion floatValue]){
                NSLog(@"[判断结果] 当前版本号:%@ < 商店版本号:%@ --- 需要更新",APP_VERSION,appInfoDic[@"results"][0][@"version"]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler ? handler(APP_VERSION,appInfoDic[@"results"][0][@"version"],openURL,YES) : nil;
                });
            }else{
                NSLog(@"[判断结果] 当前版本号:%@ > 商店版本号:%@ --- 不需要更新",APP_VERSION,appInfoDic[@"results"][0][@"version"]);
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler ? handler(APP_VERSION,appInfoDic[@"results"][0][@"version"],openURL,NO): nil;
                });
            }
        }
    }];
    [task resume];
}

@end
