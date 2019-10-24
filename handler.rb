require 'rack'
require_relative 'app'

app = App.new

Rack::Handler::WEBrick.run app
