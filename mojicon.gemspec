# frozen_string_literal: true

require_relative "lib/mojicon/version"

Gem::Specification.new do |spec|
  spec.name = "mojicon"
  spec.version = Mojicon::VERSION
  spec.authors = ["philosophynote"]
  spec.email = ["adverdest@gmail.com"]

  spec.summary = "Japanese converter"
  spec.description = <<~DESC
    Provides a wide range of text transformation functionalities,
    including conversions between full-width and half-width characters,
    kana and hiragana, kanji numerals to Arabic numerals,
    Arabic numerals to kanji, and more.
  DESC
  spec.homepage = "https://github.com/philosophynote/mojicon"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org/"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "#{spec.homepage}/blob/v#{spec.version}/CHANGELOG.md"
  spec.metadata["changelog_uri"] = "#{spec.homepage}/tree/v#{spec.version}"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_development_dependency "factory_bot"
  spec.add_dependency "itaiji"
  spec.add_dependency "nkf"
  spec.add_dependency "ya_kansuji"
  spec.add_dependency "zen_to_i"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
