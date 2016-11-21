platform :ios, '9.0'
use_frameworks!

target "Gigsterous" do
	pod 'MBProgressHUD', '~> 1.0'
	pod 'OHHTTPStubs'
	pod 'OHHTTPStubs/Swift'
	pod 'ObjectMapper', '~> 2.0'
	pod 'Moya', '8.0.0-beta.4'
    pod 'Bond', '~> 5.0'
    pod 'Fabric'
    pod 'Crashlytics'
end

target "GigsterousTests" do
	pod 'OHHTTPStubs'
	pod 'OHHTTPStubs/Swift'
	pod 'ObjectMapper', '~> 2.0'
	pod 'Moya', '8.0.0-beta.4'
    pod 'Bond', '~> 5.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
