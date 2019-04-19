lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fitbark/version'

Gem::Specification.new do |spec|
  spec.name          = 'fitbark'
  spec.version       = Fitbark::VERSION
  spec.authors       = ['NatyDev']
  spec.email         = ['natydev@aol.com']

  spec.summary       = 'Wrapper for FitBark API.'
  spec.description   = 'It provides simple methods to handle ' \
   'authorization and to execute HTTP calls.'
  spec.homepage      = 'https://github.com/natydev/fitbark'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the
  # 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow
  #  pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/natydev/fitbark'
    # spec.metadata["changelog_uri"] = "TODO: CHANGELOG.md URL here."
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'faker', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.63'
  spec.add_development_dependency 'webmock', '~> 3.5'
  spec.add_dependency 'addressable', '~> 2.6'
  spec.add_dependency 'faraday', '~> 0.15'
  spec.add_dependency 'oj', '~> 3.7'
  spec.add_dependency 'strict_open_struct', '~> 0.0.2'
end
