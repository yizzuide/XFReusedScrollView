Pod::Spec.new do |s|
s.name = 'XFReusedScrollView'
s.version = '1.5.0'
s.license = 'MIT'
s.summary = 'Powerful reused scrollView for IOS. Support custom extension layout.'
s.homepage = 'https://github.com/yizzuide/XFReusedScrollView'
s.authors = { 'yizzuide' => 'fu837014586@163.com' }
s.source = { :git => 'https://github.com/yizzuide/XFReusedScrollView.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '6.0'
s.source_files = 'XFReusedScrollView/**/*.{h,m}'
end