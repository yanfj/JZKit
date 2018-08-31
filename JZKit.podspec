#
# Be sure to run `pod lib lint JZKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JZKit'
  s.version          = '1.2.4'
  s.summary          = '常用框架'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       Yan's general framework
                       DESC

  s.homepage         = 'https://github.com/yanfj/JZKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yanfj' => 'yanff.us@gmail.com' }
  s.source           = { :git => 'https://github.com/yanfj/JZKit.git', :tag => s.version.to_s }
  s.social_media_url = 'http://me.yanfj.com'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.public_header_files = 'JZKit/JZKit.h'
  s.source_files = 'JZKit/JZKit.h'

  #宏
  s.subspec 'JZGeneralMacros' do |ss|
    
     ss.source_files = 'JZKit/JZGeneralMacros'
    
  end

  #类目
  s.subspec 'JZCategory' do |ss|
      
      ss.source_files = 'JZKit/JZCategory/JZCategory.h'
      #Foundation
      ss.subspec 'Foundation' do |sss|
          sss.source_files = 'JZKit/JZCategory/Foundation'
      end
      #UIKit
      ss.subspec 'UIKit' do |sss|
          
          sss.dependency 'SDWebImage','~> 4.0'
          sss.dependency 'JZKit/JZGeneralMacros'
          sss.dependency 'JZKit/JZCategory/Foundation'

          sss.source_files = 'JZKit/JZCategory/UIKit'
      end
      #编码
      ss.subspec 'Unicode' do |sss|
          
          sss.dependency 'JZKit/JZCategory/Foundation'
          sss.source_files = 'JZKit/JZCategory/Unicode'
      end
      
  end
  
  #网络
  s.subspec 'JZNetworkService' do |ss|
      
      ss.dependency 'AFNetworking', '~> 3.0'
      ss.dependency 'MJExtension'
      ss.dependency 'YYCache'
      ss.dependency 'JZKit/JZGeneralMacros'
      
      ss.source_files = 'JZKit/JZNetworkService'
      
  end
  
  #设置
  s.subspec 'JZSettingsService' do |ss|
      
      ss.dependency 'JZKit/JZGeneralMacros'
      
      ss.source_files = 'JZKit/JZSettingsService'
      
  end
  
  #单例
  s.subspec 'JZBasicInstance' do |ss|
      
      ss.dependency 'JZKit/JZGeneralMacros'
      
      ss.source_files = 'JZKit/JZBasicInstance'
      
  end
  
  #地区
  s.subspec 'JZGeographicService' do |ss|
      
      ss.dependency 'JZKit/JZBasicInstance'
      ss.dependency 'MJExtension'
      ss.dependency 'YYCache'
      
      ss.source_files = 'JZKit/JZGeographicService'
      
  end
  
  #选择器
  s.subspec 'JZPickerGroup' do |ss|
      
      ss.dependency 'MMPopupView-Enhanced'
      ss.dependency 'JZKit/JZGeneralMacros'
      ss.dependency 'JZKit/JZCategory/Foundation'
      ss.dependency 'JZKit/JZGeographicService'
      
      ss.source_files = 'JZKit/JZPickerGroup'
      
  end
  
  #HUD
  s.subspec 'JZProgressHUD' do |ss|
      
      ss.dependency 'MBProgressHUD'
      ss.dependency 'JZKit/JZGeneralMacros'
      
      ss.source_files = 'JZKit/JZProgressHUD/*.{h,m}'
      ss.resources    = 'JZKit/JZProgressHUD/JZProgressHUD.bundle'
      
  end
  

end
