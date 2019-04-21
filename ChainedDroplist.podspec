#
# Be sure to run `pod lib lint ChainedDroplist.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name = "ChainedDroplist"
  s.version = "0.1.0"
  s.summary = "A chain-style droplist realized by UITableView"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description = <<-DESC
- Chain-style droplist with customer rotation icon、hostView、baseView
- Auto calculate top/bottom space to choose the best way to display 
                       DESC

  s.homepage = "https://github.com/seuzxh/ChainedDroplist"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "seuzxh" => "seuzxh@163.com" }
  s.source = { :git => "https://github.com/seuzxh/ChainedDroplist.git", :tag => s.version.to_s }
  s.ios.deployment_target = "9.0"
  s.source_files = "ChainedDroplist/**/*.{h,m}"

  s.dependency "Masonry", "~> 1.1.0"
end
