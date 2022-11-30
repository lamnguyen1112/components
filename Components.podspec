Pod::Spec.new do |s|
  s.name = 'Components'
  s.version = '0.5'
  s.summary = 'Components'
  s.homepage = 'https://github.com/lamnguyen1112/components.git'
  s.authors = { 'Lam Nguyen' => 'lamnguyen1112@gmail.com' }
  s.source = { :git => 'https://github.com/lamnguyen1112/components.git', :branch => 'main',
                   :tag => s.version.to_s }

  s.source_files = 'Sources/**/*.{swift}'
#  s.resource = 'Resources/**/*.*'

  s.ios.deployment_target = '13.0'
  s.swift_version = '5.0'
  s.license      = { :type => "MIT", :file => "LICENSE" }

#  s.static_framework = true
#  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
#  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  
  s.dependency 'CoreExtension'
  s.dependency 'SnapKit'
  s.dependency 'RxSwift', '6.5.0'
  s.dependency 'RxCocoa', '6.5.0'
  s.dependency 'RxSwiftExt'
  s.dependency 'SkeletonView'

end
