# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

def rx_swift
  pod 'RxSwift'
end

def rx_cocoa
  pod 'RxCocoa'
end

target 'DomainPlatform' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DomainPlatform
  rx_swift

end

target 'NetworkPlatform' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for NetworkPlatform
  rx_swift
  rx_cocoa
  pod 'Alamofire'
  pod 'RxAlamofire'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'
  pod 'SwiftyJSON'

end

target 'WeatherApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeatherApp
  rx_cocoa
  rx_swift
  pod 'RxDataSources'
#  pod 'QueryKit'

end
