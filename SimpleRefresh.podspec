Pod::Spec.new do |s|
  s.name = "SimpleRefresh"
  s.version = "0.0.8"
  s.summary = "So simple pull to refresh framework in iOS written by Swift5"

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
  s.resources = ["SimpleRefresh/Assets/*.xcassets"]
  s.swift_version = "5.0"
end
