require_relative '../spec_helper'

describe 'lines' do
  describe 'GET /' do
    before { get '/' }
    it { expect(last_response.status).to eq 404 }
  end

  describe 'GET /lines' do
    context 'when provided with a valid integer line parameter' do
      context 'for first line' do
        before { get '/lines/1' }

        it { expect(last_response.status). to eq 200 }
        it { expect(last_response.body).to eq 'datafile' }
      end

      context 'for last line' do
        before { get '/lines/4' }

        it { expect(last_response.status). to eq 200 }
        it { expect(last_response.body).to eq 'for testing' }
      end

      context 'for a line somewhere inside' do
        before { get '/lines/2' }

        it { expect(last_response.status).to eq 200 }
        it { expect(last_response.body).to eq 'has some data' }
      end
    end

    context 'when provided with an invalid parameter' do
      context 'that is out of range' do
        before { get 'lines/10' }
        it { expect(last_response.status).to eq 413 }
      end

      context 'that is a negative integer' do
        before { get 'lines/-10' }
        it { expect(last_response.status).to eq 413 }
      end

      context 'that is not a string' do
        before { get 'lines/10a' }
        it { expect(last_response.status).to eq 413 }
      end

      context 'that is a decimal' do
        before { get 'lines/10.4' }
        it { expect(last_response.status).to eq 413 }
      end
    end
  end
end
