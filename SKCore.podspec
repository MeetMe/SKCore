Pod::Spec.new do |s|
  s.name         = 'SKCore'
  s.version      = '1.0'
  s.summary      = 'SKCore – A Simplification Toolset (Core Graphics, Autolayout and more)'
  s.homepage     = 'https://github.com/MeetMe/SKCore.git'
  s.license      = 'GNU'
  s.author       = { 'Jedidiah Laudenslayer' => 'jlaudenslayer@meetme.com' }
  s.source       = { :git => 'https://github.com/MeetMe/SKCore.git', :tag => 'v1.0' }
  s.platform     = :ios, '6.0'
  s.source_files = 'Controller/**/*.{h,m}', 'Drawing/**/*.{h,m}', 'Layout/**/*.{h,m}', 'Util/**/*.{h,m}', 'SKCore.h'
  s.requires_arc = true
  s.framework  = 'Foundation', 'UIKit', 'SystemConfiguration', 'CoreGraphics'
end