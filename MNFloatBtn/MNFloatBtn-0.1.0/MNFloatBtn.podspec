Pod::Spec.new do |s|
  s.name = "MNFloatBtn"
  s.version = "0.1.0"
  s.summary = "A short description of MNFloatBtn."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"miniLV"=>"https://github.com/miniLV"}
  s.homepage = "https://github.com/miniLV/MNFloatBtn"
  s.description = "'\u{4e00}\u{884c}\u{4ee3}\u{7801}\u{521b}\u{5efa}\u{4e00}\u{4e2a}\u{5168}\u{5c40}\u{60ac}\u{6d6e}\u{6309}\u{94ae}\u{ff0c}\u{53ef}\u{4ee5}\u{5feb}\u{901f}\u{67e5}\u{770b}\u{5f53}\u{524d}App\u{7248}\u{672c}\u{4fe1}\u{606f}'"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/MNFloatBtn.framework'
end
