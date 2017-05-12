platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

target "Gigsterous" do
    pod 'MBProgressHUD', '~> 1.0'
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'ObjectMapper', '~> 2.0'
    pod 'AlamofireObjectMapper', '~> 4.0'
    pod 'Moya'
    pod 'Bond', '~> 6.0'
    pod 'Fabric'
    pod 'Crashlytics'

    target "GigsterousTests" do
        inherit! :complete
    
        pod 'OHHTTPStubs'
        pod 'OHHTTPStubs/Swift'
    end

    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
                config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
            end
        end
    end
end
