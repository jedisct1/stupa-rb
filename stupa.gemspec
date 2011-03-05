# -*- encoding: utf-8 -*-
require File.expand_path('../lib/stupa/version', __FILE__)

Gem::Specification.new do |s|
  s.name = %q{stupa}
  s.version  = Stupa::VERSION::STRING
  s.platform = Gem::Platform::RUBY

  s.authors = ['Frank Denis']
  s.email   = ['j at pureftpd dot org']

  s.homepage    = %q{http://github.com/jedisct1/stupa-rb}
  s.summary     = %q{Ruby client library for Stupa}
  s.description = %q{Ruby client library for Stupa}

  s.extra_rdoc_files = ['README.markdown']

  s.add_runtime_dependency 'faraday', '~> 0.5.3'
  
  s.add_development_dependency 'bundler', '~> 1.0'
  s.add_development_dependency 'rake', '~> 0.8'
  s.add_development_dependency 'shoulda', '~> 2.11'
  s.add_development_dependency 'test-unit', '~> 2.1'
  
  s.required_rubygems_version = Gem::Requirement.new('>= 1.3.6') \
      if s.respond_to? :required_rubygems_version=
    
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']      
    
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end
