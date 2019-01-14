
Pod::Spec.new do |s|
  s.name         = "RNUserAgent"
  s.version      = "1.0.0"
  s.summary      = "RNUserAgent"
  s.description  = <<-DESC
                  RNUserAgent
                   DESC
  s.homepage     = "https://github.com/bebnev/react-native-user-agent"
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "author" => "bambr.ab@gmail.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/bebnev/react-native-user-agent.git", :tag => "master" }
  s.source_files  = "**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end


