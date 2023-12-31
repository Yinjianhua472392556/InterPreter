#
# Be sure to run `pod lib lint MyPascalInterPreter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MyPascalInterPreter'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MyPascalInterPreter.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Yinjianhua472392556/InterPreter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yjh' => '18620526218@163.com' }
  s.source           = { :git => 'https://github.com/Yinjianhua472392556/InterPreter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'MyPascalInterPreter/Classes/**/*'
  
  #
  s.subspec 'Lexer' do |package|
    package.source_files = 'MyPascalInterPreter/Classes/Lexer/**/*'
  end

  #
  s.subspec 'Parser' do |package|
    package.source_files = 'MyPascalInterPreter/Classes/Parser/**/*'
  end
  
  #
  s.subspec 'Interpreter' do |package|
    package.source_files = 'MyPascalInterPreter/Classes/Interpreter/**/*'
  end
  
  #
  s.subspec 'SemanticAnalyzer' do |package|
    package.source_files = 'MyPascalInterPreter/Classes/SemanticAnalyzer/**/*'
  end

  
  # s.resource_bundles = {
  #   'MyPascalInterPreter' => ['MyPascalInterPreter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
