
Pod::Spec.new do |s|
  s.name             = 'YYKit-used'
  s.version          = '1.0.7'
  s.summary          = 'YYKit常用类'

  s.description      = <<-DESC
    避免导入所有YYKit文件,增加IPA的体积
                       DESC

  s.homepage         = 'https://github.com/Iyongjie/YYKit-used.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李永杰' => 'iyongjie@yeah.net' }
  s.source           = { :git => 'https://github.com/Iyongjie/YYKit-used.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'

  s.requires_arc = true
  s.source_files = 'YYKit-used/**/*.{h,m}'
  s.public_header_files = 'YYKit-used/**/*.{h}'

  s.libraries = 'z', 'sqlite3'
  s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage', 'QuartzCore', 'ImageIO', 'AssetsLibrary', 'Accelerate', 'MobileCoreServices', 'SystemConfiguration'
  s.ios.vendored_frameworks = 'Vendor/WebP.framework'

end
