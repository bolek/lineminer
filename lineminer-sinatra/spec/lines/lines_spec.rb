require_relative '../spec_helper'

describe 'lines' do
  describe 'GET /' do
    before { get '/' }
    it { expect(last_response.status).to eq 404 }
  end

  describe 'GET /lines' do
    context 'when provided with a valid integer line parameter' do
      before { get '/lines/2' }

      it { expect(last_response.status).to eq 200 }
      it { expect(last_response.body).to eq 'has some data' }
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

      context 'that is not an integer' do
        before { get 'lines/10a' }
        it { expect(last_response.status).to eq 413 }
      end
    end
  end
end
