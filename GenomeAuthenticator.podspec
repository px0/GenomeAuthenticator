#
#  Be sure to run `pod spec lint GenomeAuthenticator.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "GenomeAuthenticator"
  s.version      = "0.0.1"
  s.summary      = "Authenticate through Genome"

  s.description  = <<-DESC
				   Checks your authentication through Genome in a Reactive manner
				   and prompts the user to login if no auth cookie has been found
                   DESC

  s.homepage     = "https://github.com/px0/GenomeAuthenticator"
  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "Maximilian Gerlach" => "m@px0.de" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/px0/GenomeAuthenticator.git", :branch => "master"}

  s.source_files  = "GenomeAuthenticator/GenomeAuthenticator.{h,m}"
  s.requires_arc = true
  s.dependency 'Reachability'
  s.dependency 'ReactiveCocoa'
  s.dependency 'AFNetworking'

end
