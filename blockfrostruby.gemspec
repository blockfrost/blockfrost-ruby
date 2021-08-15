# frozen_string_literal: true

require_relative 'lib/blockfrostruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'blockfrostruby'
  spec.version       = Blockfrostruby::VERSION
  spec.authors       = ['Ivan (https://github.com/18bitmood)']
  spec.email         = ['ivan.papushoi@mail.ru']

  spec.summary       = 'Ruby SDK to work with Blockfrost (Cardano Blockchain API)'
  spec.description   = "Blockfrost is a hosted API as a service serving the data from the Cardano blockchain.\
                        This gem is Ruby SDK for Blockfrost.io to enable developers\
                        to use full power of this API without having to create basic functions for it.\
                        The OpenAPI documentation is hosted at https://github.com/blockfrost/openapi.\
                        This gem is licensed under ASL 2.0."
  spec.homepage      = 'https://github.com/blockfrost/blockfrost-ruby'
  spec.required_ruby_version = '>= 2.5.0'

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/blockfrost/blockfrost-ruby'
  spec.metadata['changelog_uri'] = 'https://github.com/blockfrost/blockfrost-ruby/blob/master/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
