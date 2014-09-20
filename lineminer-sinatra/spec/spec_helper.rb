# spec/spec_helper.rb
ENV['RACK_ENV'] = 'test'

require_relative File.join('..', 'app')

set :datafile, 'spec/fixtures/datafile_test'

RSpec.configure do
  include Rack::Test::Methods

  def app
    LineMiner
  end
end
