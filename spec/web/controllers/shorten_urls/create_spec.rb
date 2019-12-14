RSpec.describe Web::Controllers::ShortenUrls::Create, type: :action do
  let(:action) { described_class.new }
  let(:params) { {url: 'www.example.com'} }

  describe 'URL is missing' do
    it 'return an error' do
      response = action.call({})

      expect(response[0]).to eq(400)
      expect(response[1]['Content-Type']).to eq('application/json')
      expect(response[2]).to eq(error: 'Url is missing')
    end
  end

  describe 'URL is present' do
    context 'SHORTCODE is present' do
      xit 'return an error when the shortcode is already in use' do
        params.merge!(shortcode: 'abc789XYZ')

        response = action.call(params)

        expect(response[0]).to eq(409)
        expect(response[1]['Content-Type']).to eq('application/json')
        expect(response[2]).to eq(error: 'The shortcode is already in use')
      end

      it 'return an error when the shortcode does not meet the regexp' do
        params.merge!(shortcode: 'abc')

        response = action.call(params)

        expect(response[0]).to eq(422)
        expect(response[1]['Content-Type']).to eq('application/json')
        expect(response[2]).to eq(error: 'Shortcode is in invalid format')
      end

      it 'return a successful response' do
        response = action.call(params)

        expect(response[0]).to eq(201)
        expect(response[1]['Content-Type']).to eq('application/json')
        expect(response[2]).to eq(shortcode: params[:url])
      end
    end

    context 'SHORTCODE is not present' do
      it 'return a successful response' do
        response = action.call(params)

        expect(response[0]).to eq(201)
        expect(response[1]['Content-Type']).to eq('application/json')
        expect(response[2]).to have_key?(:shortcode)
      end
    end
  end
end
