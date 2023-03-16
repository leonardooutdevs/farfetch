require 'rails_helper'

RSpec.describe 'SocialNetworks' do
  describe 'GET index' do
    subject(:index) { get social_networks_path }

    context 'when success' do
      let(:twitter_response) do
        instance_double(RestClient::Response, body: file_fixture('social_networks/twitter.json').read)
      end

      let(:facebook_response) do
        instance_double(RestClient::Response, body: file_fixture('social_networks/facebook.json').read)
      end

      let(:instagram_response) do
        instance_double(RestClient::Response, body: file_fixture('social_networks/instagram.json').read)
      end

      before do
        allow(RestClient::Request)
          .to receive(:execute).with(method: :get, url: 'https://takehome.io/twitter').and_return(twitter_response)
        allow(RestClient::Request)
          .to receive(:execute).with(method: :get, url: 'https://takehome.io/facebook').and_return(facebook_response)
        allow(RestClient::Request)
          .to receive(:execute).with(method: :get, url: 'https://takehome.io/instagram').and_return(instagram_response)
      end

      it_behaves_like 'a request'

      it do
        index and expect(JSON.parse(response.body)).to include(
          'twitter' => a_kind_of(Array),
          'facebook' => a_kind_of(Array),
          'instagram' => a_kind_of(Array)
        )
      end
    end

    context 'when request fail' do
      before do
        allow(RestClient::Request)
          .to receive(:execute).with(method: :get, url: 'https://takehome.io/twitter').and_raise('boom')
      end

      it_behaves_like 'a request', :unprocessable_entity
    end
  end
end
