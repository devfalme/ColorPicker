project '色の選択.xcodeproj'
inhibit_all_warnings!

platform :ios, '9.1'

target '色の選択' do
  #use_frameworks!

  pod 'Router_t', '~>0.0.2'
  pod 'AFNetworking'
  pod 'Masonry'
  pod 'QMUIKit'
  pod 'ChameleonFramework'
  pod 'IQKeyboardManager'
  pod 'ReactiveCocoa', '2.5'
  pod 'LKDBHelper'
  pod 'ZLPhotoBrowser'
  pod 'JPush'
end
post_install do |installer|
  installer.pods_project.targets.each do |target|
 target.build_configurations.each do |config|
  if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 8.0
    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '8.0'
     end
   end
  end
end
