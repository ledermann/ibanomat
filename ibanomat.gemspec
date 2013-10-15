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

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client'
  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'webmock'
end
