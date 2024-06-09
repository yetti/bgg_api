require "simplecov"
require "simplecov-cobertura"

SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter
])

SimpleCov.start "rails" do
  # enable_coverage :branch

  add_filter do |source_file|
    source_file.lines.count < 10
  end
end
