require 'bundler/setup'
require 'quick_study'
require 'pry'
require 'json-schema'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:all) do
    QuickStudy.configure do |c|
      c.quick_study_dir = File.expand_path('.') + '/spec/quick_study_dir'
    end
  end
end
