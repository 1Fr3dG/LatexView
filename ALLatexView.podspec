
Pod::Spec.new do |s|
  s.name             = 'ALLatexView'
  s.version          = '0.1.0'
  s.summary          = 'Math equation rendering'

  s.description      = <<-DESC
SwiftUI Math equation rendering with Katex.
                       DESC

  s.homepage         = 'https://github.com/1Fr3dG/LatexView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alfred Gao' => 'alfredg@alfredg.org' }
  s.source           = { :git => 'https://github.com/1Fr3dG/LatexView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.resources = ['ALLatexView/Libs/*']
  s.source_files = 'ALLatexView/Classes/**/*'
  s.swift_version = '5.0'
  
end

