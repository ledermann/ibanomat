# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ibanomat/version'

Gem::Specification.new do |spec|
  spec.name          = 'ibanomat'
  spec.version       = Ibanomat::VERSION
  spec.authors       = ['Georg Ledermann']
  spec.email         = ['mail@georg-ledermann.de']
  spec.description   = 'Germany only: Bankleitzahl & Kontonummer => IBAN'
  spec.summary       = 'Wrapper for a web service to calculate the IBAN of german bank account numbers'
  spec.homepage      = 'http://github.com/ledermann/ibanomat'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock'
end
