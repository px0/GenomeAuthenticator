

Pod::Spec.new do |s|

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
