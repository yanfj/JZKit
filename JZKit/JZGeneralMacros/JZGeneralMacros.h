/***********************************************************************

                        ::
                       :;J7, :,                        ::;7:
                       ,ivYi, ,                       ;LLLFS:
                       :iv7Yi                       :7ri;j5PL
                      ,:ivYLvr                    ,ivrrirrY2X,
                      :;r@Wwz.7r:                :ivukexianli.
                     :iL7::,:::iiirii:ii;::::,,irvF7rvvLujL7ur
                    ri::,:,::i:iiiiiii:i:irrv177JX7rYXqZEkvv17
                 ;i:, , ::::iirrririi:i:::iiir2XXvii;L8OGJr71i
               :,, ,,:   ,::ir@mingyi.irii:i:::j1jri7ZBOS7ivv,
                 ,::,    ::rv77iiiriii:iii:i::,rvLqshuhao.Li,
              ,,      ,, ,:ir7ir::,:::i;ir:::i:i::rSGGYri712:
            :::  ,v7r:: ::rrv77:, ,, ,:i7rrii:::::, ir7ri7Lri
           ,     2OBBOi,iiir;r::        ,irriiii::,, ,iv7Luur:
         ,,     i78MBBi,:,:::,:,  :7FSL: ,iriii:::i::,,:rLqXv::
         :      iuMMP: :,:::,:ii;2GY7OBB0viiii:i:iii:i:::iJqL;::
        ,     ::::i   ,,,,, ::LuBBu BBBBBErii:i:i:i:i:i:i:r77ii
       ,       :       , ,,:::rruBZ1MBBqi, :,,,:::,::::::iiriri:
      ,               ,,,,::::i:  @arqiao.       ,:,, ,:::ii;i7:
     :,       rjujLYLi   ,,:::::,:::::::::,,   ,:i,:,,,,,::i:iii
     ::      BBBBBBBBB0,    ,,::: , ,:::::: ,      ,,,, ,,:::::::
     i,  ,  ,8BMMBBBBBBi     ,,:,,     ,,, , ,   , , , :,::ii::i::
     :      iZMOMOMBBM2::::::::::,,,,     ,,,,,,:,,,::::i:irr:i:::,
     i   ,,:;u0MBMOG1L:::i::::::  ,,,::,   ,,, ::::::i:i:iirii:i:i:
     :    ,iuUuuXUkFu7i:iii:i:::, :,:,: ::::::::i:i:::::iirr7iiri::
     :     :rk@Yizero.i:::::, ,:ii:::::::i:::::i::,::::iirrriiiri::,
      :      5BMBBBBBBSr:,::rv2kuii:::iii::,:i:,, , ,,:,:i@petermu.,
           , :r50EZ8MBBBBGOBBBZP7::::i::,:::::,: :,:,::i;rrririiii::
               :jujYY7LS0ujJL7r::,::i::,::::::::::::::iirirrrrrrr:ii:
            ,:  :@kevensun.:,:,,,::::i:i:::::,,::::::iir;ii;7v77;ii;i,
            ,,,     ,,:,::::::i:iiiii:i::::,, ::::iiiir@xingjief.r;7:i,
         , , ,,,:,,::::::::iiiiiiiiii:,:,:::::::::iiir;ri7vL77rrirri::
          :,, , ::::::::i:::i:::i:i::,,,,,:,::i:i:::iir;@Secbone.ii:::
 
                 JZKit                JZGeneralMacros
 //  Created by Yan's on 2018/4/26.
 //  Copyright © 2018年 Yan's All rights reserved.
**********************************************************************/


#ifndef JZGeneralMacros_h
#define JZGeneralMacros_h


//-------------------   宏 -------------------------
//弱引用
#define WS(weak_self)  __weak __typeof(&*self)weak_self = self;

//替代NSLog
#if DEBUG
#define NSLog(FORMAT, ...) {\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];\
[dateFormatter setDateStyle:NSDateFormatterMediumStyle];\
[dateFormatter setTimeStyle:NSDateFormatterShortStyle];\
[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; \
NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];\
NSString *fileName = [NSString stringWithUTF8String:__FILE__];\
fileName = [[fileName stringByReplacingOccurrencesOfString:@".m" withString:@""] lastPathComponent];\
fprintf(stderr,"%s JZKit(Debug):[%s:%d]: %s\n",[timeString UTF8String],[fileName UTF8String], __LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);\
}
#else
#define NSLog(FORMAT, ...) nil
#endif

//------------------- 获取设备大小 -------------------------
//屏幕长度宽度
#define UI_SCREEN_HEIGHT  ([UIScreen mainScreen].bounds.size.height)
#define UI_SCREEN_WIDTH   ([UIScreen mainScreen].bounds.size.width)

//适配比
#define UI_SCALE(dp)      (int)round(((dp) * (UI_SCREEN_WIDTH / 375.f)))

//------------------- 获取设备数据 -------------------------
//获取系统版本
#define SYSTEM_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]
//获取app名字
#define APP_NAME          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

//获取bundleID
#define APP_BUNDLE_ID     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

//获取Build号
#define APP_BUILD         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

//获取Version号
#define APP_VERSION       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//获取设备横屏情况
#define UI_IS_LANDSCAPE   ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
//获取设备类型
#define UI_IS_IPAD        [[UIDevice currentDevice].model isEqualToString:@"iPad"]
#define UI_IS_IPHONE      [[UIDevice currentDevice].model isEqualToString:@"iPhone"]
#define UI_IS_IPOD        [[UIDevice currentDevice].model isEqualToString:@"iPod touch"]

//判断设备尺寸
#define UI_IS_IPHONE_4_0  (UI_IS_IPHONE && UI_SCREEN_HEIGHT == 568.f && UI_SCREEN_WIDTH == 320.f)
#define UI_IS_IPHONE_4_7  (UI_IS_IPHONE && UI_SCREEN_HEIGHT == 667.f && UI_SCREEN_WIDTH == 375.f)
#define UI_IS_IPHONE_5_5  (UI_IS_IPHONE && UI_SCREEN_HEIGHT == 736.f && K_SCREEN_WIDTH == 414.f)
#define UI_IS_IPHONE_X    (UI_IS_IPHONE && UI_SCREEN_HEIGHT == 812.f && UI_SCREEN_WIDTH == 375.f)

//------------------- 获取控件大小 -------------------------
//导航栏高度
#define NAVIGATIONBAR_HEIGHT     44.f

//状态栏高度
#define STATUSBAR_HEIGHT         (UI_IS_IPHONE_X ? 44.f : 20.f)

//导航栏+状态栏高度
#define NAVIGATION_HEIGHT        (NAVIGATIONBAR_HEIGHT + STATUSBAR_HEIGHT)

//选项卡高度
#define TABBAR_HEIGHT            (UI_IS_IPHONE_X ? 83.f : 49.f)

//-------------------- 颜色 -----------------------------
//带有RGBA的颜色设置
#define RGB_COLOR(R, G, B, A)   [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:A/1.f]


//-------------------- 字符串 -----------------------------
#define EMPTY_STRING        @""

//-------------------- 字典 -----------------------------
#define EMPTY_PARA          @{}

//-------------------- 本地化 ---------------------------
#define LS(key)             NSLocalizedString(key, nil)

//-------------------- 图片  ---------------------------
#define IMG(name)           [UIImage imageNamed:name]

//-------------------- 字体  --------------------------
#define FONT(size)          [UIFont systemFontOfSize:size]
#define FONT_BOLD(size)     [UIFont boldSystemFontOfSize:size]

//-------------------- 保留的tag值 ---------------------
#define TAG_BASIC           1000




#endif /* JZGeneralMacros */
