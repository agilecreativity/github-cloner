# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'github_cloner/version'
Gem::Specification.new do |spec|
  spec.name          = 'github-cloner'
  spec.version       = GithubCloner::VERSION
  spec.authors       = ['Burin Choomnuan']
  spec.email         = ['agilecreativity@gmail.com']
  spec.summary       = %q{Clone/list Github repository for a given user/organization include private/public in one go}
  spec.description   = %q(
    Clone/list multiple Github repositories for a given user/organization including private repos easily.
    e.g.$github-cloner --base-dir ~/projects --user awesome_dev --language "Emacs Lisp" --clone
    ).gsub(/^\s+/, " ")
  spec.homepage      = 'https://github.com/agilecreativity/github-cloner'
  spec.required_ruby_version = ">= 3.0.0"
  spec.license       = 'MIT'
  spec.files         = Dir.glob('{bin,lib,spec,test}/**/*') + %w(Gemfile
                                                                 Rakefile
                                                                 github_cloner.gemspec
                                                                 README.md
                                                                 CHANGELOG.md
                                                                 LICENSE
                                                                 .rubocop.yml
                                                                 .gitignore)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_runtime_dependency 'github_api', '~> 0.19'
  spec.add_development_dependency 'awesome_print', '~> 1.9'
  spec.add_development_dependency 'bundler', '~> 2.2'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'minitest-spec-context', '~> 0.0'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'pry-byebug', '~> 3.8'
  spec.add_development_dependency 'rake', '~> 10.5'
  spec.add_development_dependency 'rubocop', '~> 0.93'
  spec.add_development_dependency 'yard', '~> 0.9'
end
