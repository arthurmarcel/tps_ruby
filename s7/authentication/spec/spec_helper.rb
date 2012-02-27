require 'bundler'

Bundler.setup :default, :development, :test

require 'rack/test'
require_relative '../sinatra_authentication'
RSpec.configure do |config|
  config.include Rack::Test::Methods
end


