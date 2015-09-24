require 'vcr'
require 'simplecov'

SimpleCov.start do
  minimum_coverage 100
  refuse_coverage_drop
  add_filter "/spec/"
  add_filter "/vendor/"
end

require './lib/s3-proxy.rb'
require 'support/rack_request_mock'

ENV['RUBY_ENV'] = 'development'


VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'

  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
