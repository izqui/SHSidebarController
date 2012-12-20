#
# Be sure to run `pod spec lint SHSidebarController.podspec' to ensure this is a
# valid spec.
#
# Remove all comments before submitting the spec. Optional attributes are commented.
#
# For details see: https://github.com/CocoaPods/CocoaPods/wiki/The-podspec-format
#
Pod::Spec.new do |s|
  s.name         = "SHSidebarController"
  s.version      = "0.0.1"
  s.summary      = "Sidebar controller inspired by NSSidebarController by Nacho Soto."
  s.description  = <<-DESC
	Sidebar controller built in order to create Showy. (http://showyapp.com)
	It uses UIView-Origami by XYstudio and is inspired by NSSidebarController by Nacho Soto.
  	DESC
  s.homepage     = "https://github.com/izqui/SHSidebarController"
  s.license      = 'None'
  s.author       = { "Jorge Izquierdo" => "izqui97@gmail.com" }
  s.source       = { :git => "https://github.com/JAManfredi/SHSidebarController.git", :commit => "0.0.1" } }
  s.platform     = :ios, '5.0'
  s.source_files = 'SHSidebarController', 'SHSidebarController/*.{h,m}'
  s.resources = "SHSidebarController/*.png"
  s.frameworks = 'CoreGraphics', 'QuartzCore'
  s.requires_arc = true
end