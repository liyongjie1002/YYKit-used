
Pod::Spec.new do |s|
  s.name             = 'YYKit-used'
  s.version          = '0.0.1'
  s.summary          = 'YYKit常用类'

  s.description      = <<-DESC
    持续更新，避免导入所有YYKit文件
                       DESC

  s.homepage         = 'https://github.com/Iyongjie/YYKit-used.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '李永杰' => 'iyongjie@yeah.net' }
  s.source           = { :git => 'https://github.com/Iyongjie/YYKit-used.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'YYKit/**/*'
  
end