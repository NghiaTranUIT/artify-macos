source 'https://github.com/CocoaPods/Specs.git'

platform :osx, '10.12'
use_frameworks!
inhibit_all_warnings!
workspace 'ArtifyWorkspace.xcworkspace'

#
# ============================= Artify ==================================
#

def pod_required
    pod 'RxSwift' , '~> 4.0.0'
    pod 'RxCocoa' , '~> 4.0.0'
    pod 'RxOptional'
    pod 'Alamofire'
    pod 'Unbox'
    pod 'Wrap'
    pod 'Action'
    pod 'RxOptional'
    pod 'Moya/RxSwift', '~> 11.0'
    pod 'RxNuke'
    pod 'Sparkle'
end


# Artify
target 'Artify' do
    project 'Artify/Artify.xcodeproj'
    pod_required
end

#
# ============================= Artify Core ==================================
#

# Artify Core
target 'artify-core' do
    project 'artify-core/artify-core.xcodeproj'
    pod_required
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
