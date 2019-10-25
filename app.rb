
# http://localhost:9292/time?format=year%2Cmonth%2Cday%2Chour%2Cminute%2Csecond

require 'byebug'
require_relative 'time_formatter.rb'

class App

  def call(env)
    @request = Rack::Request.new(env)
    response = TimeFormatter.new(@request.params)
    case @request.path_info
    when response.valid_path?
      if response.valid_format?
        response(200, response.call)
      else
        response(400, "Unknown time format #{ response.wrong_formats }")
      end
    else
      response(404, 'Not Found')
    end
  end

  private

  def headers
    { 'Content-type' => 'text/plain'}
  end

  def response(status, body)
    response = Rack::Response.new
    response.status = status
    response.write body.to_s
    response.add_header('Content-Type', 'text/plain')
    response.finish
  end
end