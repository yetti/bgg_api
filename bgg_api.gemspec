# frozen_string_literal: true

require_relative "lib/bgg_api/version"

Gem::Specification.new do |spec|
  spec.name = "bgg_api"
  spec.version = BggApi::VERSION
  spec.authors = ["Yetrina Battad"]
  spec.email = ["hello@yetti.io"]

  spec.summary = "Board Game Geek API Wrapper"
  spec.description = "Request data from the Board Game Geek API and parse it into Ruby objects."
  spec.homepage = "https://github.com/yetti/bgg_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/yetti/bgg_api/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", ">= 1.10", "< 3.0"
  spec.add_dependency "faraday-retry", "~> 2.2", ">= 2.2.1"
  spec.add_dependency "faraday-decode_xml", "~> 0.2.1"
  spec.add_dependency "faraday-http-cache", "~> 2.5", ">= 2.5.1"
  spec.add_dependency "faraday-follow_redirects", "~> 0.3.0"
  spec.add_dependency "httpx", "~> 1.2", ">= 1.2.5"

  spec.add_development_dependency "rake", "~> 13.2", ">= 13.2.1"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "simplecov", "~> 0.22.0"
  spec.add_development_dependency "simplecov-cobertura", "~> 2.1"

  spec.add_development_dependency "standard", ">= 1.36.0"

  spec.add_development_dependency "rubocop", "~> 1.63.0"
  spec.add_development_dependency "rubocop-rake", "~> 0.6.0"
  spec.add_development_dependency "rubocop-rspec", "~> 2.31"
  spec.add_development_dependency "rubocop-performance", "~> 1.21"
end
