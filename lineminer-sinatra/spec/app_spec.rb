require_relative 'spec_helper'

describe LineMiner do
  let(:file_lines) { File.readlines(subject.settings.datafile) }

  describe 'lines' do
    def get_line(index)
      file_lines[index - 1].strip
    end

    describe 'GET /' do
      before { get '/' }
      it { expect(last_response.status).to eq 404 }
    end

    describe 'GET /lines' do
      context 'when provided with a valid integer line parameter' do
        context 'for first line' do
          before { get '/lines/1' }

          it { expect(last_response.status). to eq 200 }
          it { expect(last_response.body).to eq get_line(1) }
        end

        context 'for last line' do
          before { get "/lines/#{ file_lines.size }" }

          it { expect(last_response.status). to eq 200 }
          it { expect(last_response.body).to eq get_line(file_lines.size) }
        end

        context 'for a line somewhere inside' do
          before { get '/lines/2' }

          it { expect(last_response.status).to eq 200 }
          it { expect(last_response.body).to eq get_line(2) }
        end
      end

      context 'when provided with an invalid parameter' do
        context 'that is out of range' do
          before { get 'lines/10' }
          it { expect(last_response.status).to eq 413 }
        end

        context 'that is 0' do
          before { get 'lines/0' }
          it { expect(last_response.status).to eq 400 }
        end

        context 'that is a negative integer' do
          before { get 'lines/-10' }
          it { expect(last_response.status).to eq 400 }
        end

        context 'that is not a string' do
          before { get 'lines/10a' }
          it { expect(last_response.status).to eq 400 }
        end

        context 'that is a decimal' do
          before { get 'lines/10.4' }
          it { expect(last_response.status).to eq 400 }
        end
      end
    end
  end
end
