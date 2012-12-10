require 'rubygems'
require 'bundler'
Bundler.setup(:default)
Bundler.require

use Rack::Head
run Gobble::ShimServer.new
