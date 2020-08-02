lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quick_study/version'

Gem::Specification.new do |spec|
  spec.name = 'quick_study'
  spec.version = QuickStudy::VERSION
  spec.authors = ['Joseph Platta']
  spec.email = ['jwplatta@gmail.com']
  spec.date = '2020-07-30'

  spec.summary = 'Quick Study'
  spec.description = 'Set of tools for studying efficiently.'

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.homepage = 'https://rubygems.org/gems/quick_study'
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "http://foobar.com"
  spec.metadata["changelog_uri"] = "http://foobar.com"

  spec.license = 'MIT'

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.executables = ['quick_study']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
