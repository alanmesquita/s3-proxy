Bundler.require :default, (ENV['RUBY_ENV'] ||= 'development')

module S3Proxy
  include Configureasy
  config_name :config
end

Dir['./app/controller/*.rb'].each { |file| require file }
Dir['./app/model/*.rb'].each { |file| require file }
Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }
