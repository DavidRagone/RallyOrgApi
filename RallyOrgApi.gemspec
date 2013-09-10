# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rally_org_api/version'

Gem::Specification.new do |spec|
  spec.name          = "RallyOrgApi"
  spec.version       = RallyOrgApi::VERSION
  spec.authors       = ["DavidRagone"]
  spec.email         = ["dmragone@gmail.com"]
  spec.description   = %q{Ruby API Wrapper for Rally.org API}
  spec.summary       = %q{Ruby API Wrapper for Rally.org API}
  spec.homepage      = "http://github.com/DavidRagone/RallyOrgApi"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "rest-client"
  spec.add_runtime_dependency "json"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
