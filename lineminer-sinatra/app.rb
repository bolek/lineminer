# app.rb
ENV['RACK_ENV'] ||= 'development'

require 'bundler'
Bundler.require :default, ENV['RACK_ENV'].to_sym

# Miner serving lines out of a file to network clients
# First line has index 1
#
# Example request:
# /lines/4
# returns 4th line from file
class LineMiner < Sinatra::Base
  set :root, File.dirname(__FILE__)

  get '/lines/:line' do
    begin
      line_index = Integer(params[:line])
    rescue ArgumentError
      return 413
    end

    return 413 if line_index < 0

    f = File.open('assets/datafile', 'r')
    response = ''
    line_index.times do
      return 413 if f.eof?
      response =  f.readline.to_s
    end

    f.close
    response.strip
  end

end
