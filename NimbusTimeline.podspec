Pod::Spec.new do |s|
  s.name         = "NimbusTimeline"
  s.version      = "0.1"
  s.summary      = "Easy to deal with timeline data and show it with tableview"
  s.description  = <<-DESC
                    Secondary development based on the most popular ios libs nimbus and AFNetworking,
                    this lib is very useful for requesting timeline data, and show it with tableview,
                    Wish u enjoy it.
                   DESC
  s.homepage     = "http://blog.sina.com.cn/jimneylee"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { 'jimneylee' => 'jimneylee@gmail.com' }
  s.source       = { :git => "https://github.com/jimneylee/NimbusTimeline", :tag => s.version.to_s }
  s.platform     = :ios
  s.ios.deployment_target = '6.0'
  s.source_files = 'NimbusTimeline/*.{h,m}'
  s.requires_arc = true
end