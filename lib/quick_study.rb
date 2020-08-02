module QuickStudy
  class << self
    attr_accessor :configuration
  end

  def self.configure
    @configuration ||= Configuration.new
    yield(configuration)
  end
end

require 'quick_study/version'
require 'quick_study/configuration'
require 'quick_study/review_question'
require 'quick_study/markdown_to_json_converter'
