#
# Be sure to run `pod lib lint MNFloatBtn.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MNFloatBtn'
  s.version          = '2.3.0'
  s.summary          = 'A short description of MNFloatBtn.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'一行代码创建一个全局悬浮按钮，可以快速查看当前App版本信息'
                       DESC

  s.homepage         = 'https://github.com/miniLV/MNFloatBtn'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'miniLV' => 'https://github.com/miniLV' }
  s.source           = { :git => 'https://github.com/miniLV/MNFloatBtn.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

 s.source_files = 'MNFloatBtn/MNFloatBtn.{h,m}','MNFloatBtn/NSDate+MNDate.{h,m}','MNFloatBtn/MNFloatContentBtn.{h,m}'

  
  s.resources = 'MNFloatBtn/MNFloatBtn.bundle'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
