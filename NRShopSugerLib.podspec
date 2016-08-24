# Be sure to run `pod lib lint NRShopSugerLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|


  s.name         = "NRShopSugerLib"
  s.version      = "0.0.5"
  s.summary      = "the part of NRCGlobalShop lib"

  s.homepage     = "https://github.com/sugerGDev/NRShopSugerLib"

  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "suger" => "gjw_2007@163.com" }

  s.platform     = :ios
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/sugerGDev/NRShopSugerLib.git", :tag => s.version.to_s }


  s.source_files  = "NRShopSugerLib/MyObject/**/*.{h,m}"

  s.public_header_files = "NRShopSugerLib/MyObject/**/*.h"

  s.requires_arc = true


  s.frameworks = "UIKit", "Foundation","Photos","QuartzCore"
  s.resources  = 'NRShopSugerLib/MyObject/Resources/*.{png,xib,nib,bundle,storyboard}'

    s.dependency 'Masonry'
    s.dependency 'YYKit'


end