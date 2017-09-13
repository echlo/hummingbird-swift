Pod::Spec.new do |s|
  s.name         = "Hummingbird"
  s.version      = "1.0.0"
  s.summary      = "This is a Swift implementation of the parser and serializer for HummingBird Object Notation."
  s.homepage     = "https://github.com/echlo/hummingbird-swift"
  s.license      = "MIT"
  s.authors      = { "Echlo, Inc" => "ava@echlo.com" }
  s.source       = { :git => "https://github.com/echlo/Hummingbird-swift.git", :tag => "#{s.version}" }
  
  s.ios.deployment_target = "8.0"
  
  s.source_files  = "Hummingbird/*.swift"
end
