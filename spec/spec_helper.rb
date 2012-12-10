require 'rubygems'
require 'bundler/setup'
require 'rack/test'
require 'gobble'
require 'debugger'

module ShimServerHelpers
  def app
    @app ||= Gobble::ShimServer.new
  end
end

RSpec.configure do |config|
  config.include Rack::Test::Methods, :type => :rack
  config.include ShimServerHelpers, :type => :rack
end
