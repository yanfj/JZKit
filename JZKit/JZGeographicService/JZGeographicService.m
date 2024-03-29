//
//  JZGeographicService.m
//  JZKit
//
//  Created by YAN on 2018/4/27.
//

#import "JZGeographicService.h"
#import "JZGeographicCache.h"
#import <YYModel/YYModel.h>

@implementation JZGeographicService
#pragma mark - 更新本地文件
- (void)updateGeographicData:(id)data forKey:(NSString *)key{
    
    [JZGeographicCache setData:data key:key];
    
}
#pragma mark - 读取文件
- (void)readGeographicDataWithKey:(NSString *)key forClass:(Class)class{
    
    id data = [JZGeographicCache dataForKey:key];
    
    NSArray<id<JZGeographicModel>> * array = [NSArray yy_modelArrayWithClass:class json:data];
    
    _dataSource = array ?:[NSArray array];
    
}
#pragma mark - 搜索
- (NSString *)searchGeographicNameWithCode:(NSInteger)code{
    
    if (_dataSource.count == 0) {
        
        return nil;
    }
    
    //获取省编码
    NSInteger provinceCode = (code/10000)*10000;
    //获取市编码
    NSInteger cityCode = (code/100)*100;
    
    if (provinceCode == code) {
        //如果是省编码
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code = %ld",code];
        NSArray<id<JZGeographicModel>> *result = [_dataSource filteredArrayUsingPredicate:predicate];
        return result.count ? [result firstObject].name : nil;
    }else if (cityCode == code){
        //如果是市编码
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code = %ld",provinceCode];
        NSArray<id<JZGeographicModel>> *result = [_dataSource filteredArrayUsingPredicate:predicate];
        if (result.count) {
            NSPredicate *cityPredicate = [NSPredicate predicateWithFormat:@"code = %ld",code];
            NSArray<id<JZGeographicModel>> *cityResult = [[result firstObject].cities filteredArrayUsingPredicate:cityPredicate];
            return cityResult.count ? [cityResult firstObject].name : nil;
        }else{
            return nil;
        }
    }else{
        //如果是区编码
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"code = %ld",provinceCode];
        NSArray<id<JZGeographicModel>> *result = [_dataSource filteredArrayUsingPredicate:predicate];
        if (result.count) {
            NSPredicate *cityPredicate = [NSPredicate predicateWithFormat:@"code = %ld",cityCode];
            NSArray<id<JZGeographicModel>> *cityResult = [[result firstObject].cities filteredArrayUsingPredicate:cityPredicate];
            if (cityResult.count) {
                NSPredicate *districtPredicate = [NSPredicate predicateWithFormat:@"code = %ld",code];
                NSArray<id<JZGeographicModel>> *districtResult = [[cityResult firstObject].districts filteredArrayUsingPredicate:districtPredicate];
                return districtResult.count ? [districtResult firstObject].name : nil;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }
}
@end
