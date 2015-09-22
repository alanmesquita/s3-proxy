require './lib/s3-proxy.rb'

use Rack::Reloader unless ENV['RUBY_ENV'] == 'production'
run S3Proxy::Application.router
