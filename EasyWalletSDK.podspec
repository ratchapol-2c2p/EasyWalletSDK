#
#  Be sure to run `pod spec lint EasyWalletSDK.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "EasyWalletSDK"
  spec.version      = "1.0.0"
  spec.summary      = "Wallet SDK from GAC 2c2p"
  spec.description  = "The SDK build for easy to use from GAC 2c2p"
  spec.homepage     = "https://github.com/ratchapol-2c2p/EasyWalletSDK"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Ratchapol Pattarakanoksiri" => "ratchapol.pat@2c2p.com" }
  spec.source       = { :git => "https://github.com/ratchapol-2c2p/EasyWalletSDK.git", :tag => "#{spec.version}" }
  spec.resource_bundles = {
    'EasyWalletSDKResources' => ['EasyWalletSDK/**/*.storyboard', 'EasyWalletSDK/**/*.xib', 'EasyWalletSDK/**/*.png']
  }
  spec.platform     = :ios, "14"  # อัปเดตค่า iOS deployment target
  spec.swift_version = "5.0"
  # spec.source_files  = "EasyWalletSDK", "EasyWalletSDK/**/*.{swift}", "EasyWalletSDK/**/**/*.{swift}"
  # spec.exclude_files = {
  #   "EasyWalletBundle" => [
  #   # 'EasyWalletSDK/**/*.xib',
  #   # 'EasyWalletSDK/**/*.gif',
  #   "EasyWalletSDK/**/*.xcassets"
  #   # 'EasyWalletSDK/**/*.ttf',
  #   # 'EasyWalletSDK/**/*.otf',
  #   # 'EasyWalletSDK/**/Auth0.plist',
  #   # 'EasyWalletSDK/**/*.lproj/*.strings'
  #   ]
  # }

  spec.source_files  = "EasyWalletSDK/**/*.{swift}"
#   spec.resource_bundles = {
#     "EasyWalletBundle" => ["EasyWalletSDK/Assets/**/*"]
#   }

  spec.static_framework = false
  
  # Dependency 
  spec.dependency 'Alamofire', '~> 5.9.1'

end
