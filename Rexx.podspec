Pod::Spec.new do |s|
  s.name             = "Rexx"
  s.summary          = "A simpler way to do regex in Swift"
  s.version          = "0.1"
  s.homepage         = "https://github.com/bstien/Rexx"
  s.license          = 'MIT'
  s.author           = { "Bastian Stien" => "bastian.stien@gmail.com" }
  s.source           = { :git => "https://github.com/bstien/Rexx.git", :tag => s.version.to_s }
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.swift_version    = '4.2'
  s.source_files     = 'Source/**/*.swift'
end
