# app.rb
ENV['RACK_ENV'] ||= 'development'

require 'bundler'
require 'sinatra'
configure { set :server, :puma }

require_relative 'lib/naive_miner'
require_relative 'lib/position_miner'

Bundler.require :default, ENV['RACK_ENV'].to_sym

# Miner serving lines out of a file to network clients
#
#
#   Possible request:
#   GET /lines/:line
#
#   Example valid:
#   GET /lines/4
#   returns 4th line from provided datafile
#
#   Line index starts from 1.
#   Negative a non-integer parameters not allowed.
class LineMiner < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :datafile,
    ENV['RACK_ENV'] == 'test' ? "#{settings.root}/assets/datafile_test" : "#{settings.root}/assets/datafile"

    set :mining_strategy, PositionMiner

  get '/lines/:line' do
    resolve_request
  end

  def resolve_request
    line_index = Integer(params[:line])
    return 413 if line_index < 0
    settings.mining_strategy.find_line(line_index, settings.datafile)
    rescue ArgumentError, EOFError, TypeError
      return 413
  end

  settings.mining_strategy.init(settings.datafile)

  run! if app_file == $PROGRAM_NAME
end
