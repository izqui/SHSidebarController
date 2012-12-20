Pod::Spec.new do |s|
  s.name         = "SHSidebarController"
  s.version      = "0.0.1"
  s.summary      = "Sidebar controller inspired by NSSidebarController by Nacho Soto."
  s.description  = <<-DESC
	Sidebar controller built in order to create Showy. (http://showyapp.com)
	It uses UIView-Origami by XYstudio and is inspired by NSSidebarController by Nacho Soto.
  	DESC
  s.homepage     = "https://github.com/izqui/SHSidebarController"
  s.license      = 'MIT'

  s.author       = { "Jorge Izquierdo" => "izqui97@gmail.com" }
  s.source       = { :git => "https://github.com/JAManfredi/SHSidebarController.git", :tag => "1.0" }
  s.platform     = :ios, '5.0'

  s.source_files = 'SHSidebarController', 'SHSidebarController/*.{h,m}'
  s.resources = "SHSidebarController/*.png"
  s.frameworks = 'CoreGraphics', 'QuartzCore'
  s.requires_arc = true
end