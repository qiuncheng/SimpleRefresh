Pod::Spec.new do |s|
  s.name = "SimpleRefresh"
  s.version = "0.0.1"
  s.summary = "A short description of SimpleRefresh."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description = <<-DESC
    A simple pull to refresh lib with highly customizable animation.
                       DESC

  s.homepage = "https://github.com/qiuncheng/SimpleRefresh"
  s.license = {:type => "MIT", :file => "LICENSE"}
  s.author = {"qiuncheng" => "qiuncheng@gmail.com"}
  s.source = {:git => "https://github.com/qiuncheng/SimpleRefresh.git", :tag => s.version.to_s}
  s.social_media_url = "https://twitter.com/vsccw"

  s.ios.deployment_target = "8.0"

  s.swift_version = "4.2"

  s.source_files = "SimpleRefresh/Classes/**/*"
  s.resources = ["SimpleRefresh/Assets/arrow-down.png"]
  # s.resource_bundles = {
  #   "SimpleRefresh" => ["SimpleRefresh/Assets/*.png"],
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
