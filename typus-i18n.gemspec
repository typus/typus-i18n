# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'typus/i18n/version'

files      = Dir['**/*'].keep_if { |file| File.file?(file) }
test_files = Dir['test/**/*'].keep_if { |file| File.file?(file) }
ignores    = Dir['doc/**/*'].keep_if { |file| File.file?(file) } + %w(.travis.yml .gitignore)

Gem::Specification.new do |spec|
  spec.name          = "typus-i18n"
  spec.version       = Typus::I18n::VERSION
  spec.authors       = ["Francesc Esplugas", "Phillip Oertel"]
  spec.email         = ["support@typuscmf.com"]
  spec.summary       = %q{Translation files for typus, the Ruby on Rails Admin Panel.}
  spec.homepage      = "http://www.typuscmf.com/"
  spec.license       = "MIT"

  spec.platform = Gem::Platform::RUBY

  spec.files         = files - test_files - ignores
  spec.test_files    = []
  spec.require_paths = ["lib"]

  spec.add_dependency "typus", "4.0.0.beta1"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "rake", "~> 10"
end
