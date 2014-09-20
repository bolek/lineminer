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
#   Only positive index integers allowed
class LineMiner < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :datafile,
    ENV['RACK_ENV'] == 'test' ? "#{settings.root}/assets/datafile_test" : "#{settings.root}/assets/datafile"
  set :mining_strategy, PositionMiner
  set :miner, settings.mining_strategy.new(settings.datafile)

  get '/lines/:line' do
    resolve_request
  end

  def resolve_request
    return 400 unless line_index_valid?(params[:line])
    settings.miner.find_line(params[:line].to_i)
    rescue Miner::OutOfRange
      return 413
  end

  def line_index_valid?(line)
    /\A\d+\z/ === line && line.to_i > 0
  end

  run! if app_file == $PROGRAM_NAME
end
