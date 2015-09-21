source 'https://rubygems.org'

gem 'rack'
gem 'rack-router'
gem 'json'
gem 'typhoeus', '>= 0.6.9'
gem 'aws-sdk-core'
gem 'configureasy'
gem 'fpm', '1.2.0'
gem 'unicorn'

group :development do
  gem 'pry-meta'
  gem 'webmock', '~> 1.20'
  gem 'rspec', '>= 3.1'
  gem 'vcr', '>= 2.9.3'
  gem 'guard'
  gem 'guard-rspec'
end

group :test do
  gem "sandi_meter", require: false
  gem "rubycritic",  require: false
  gem "simplecov",   require: false
  gem "brakeman",    require: false
end

group :development, :test do
  gem "rubocop",     require: false
end
