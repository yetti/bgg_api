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

  spec.add_dependency "faraday", "~> 1.10"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
