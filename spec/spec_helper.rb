require File.expand_path("../../lib/rack/heroku_meta", __FILE__)
require 'rack/mock'
require 'json'

RSpec.configure do |config|
  config.mock_with :rspec
end

