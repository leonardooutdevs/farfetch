require 'rails_helper'

RSpec.describe SocialNetworks::FetchData, type: :services, vcr: true do
  describe '.call' do
    subject(:call) { described_class.new.call }

    context 'when success' do
      before { allow(RestClient::Request).to receive(:execute).and_call_original }

      it { expect(call).to be_success }
      it { call and expect(RestClient::Request).to have_received(:execute).at_least(3) }

      it do
        expect(call.value!).to include(
          'twitter' => JSON.parse(file_fixture('social_networks/twitter.json').read),
          'facebook' => JSON.parse(file_fixture('social_networks/facebook.json').read),
          'instagram' => JSON.parse(file_fixture('social_networks/instagram.json').read)
        )
      end
    end

    context 'when client takehome failed' do
      before do
        allow(RestClient::Request).to receive(:execute).and_raise(RestClient::InternalServerError)
        allow(LogHelper).to receive(:exception).and_call_original
      end

      it { expect(call).to be_success }
      it { call and expect(RestClient::Request).to have_received(:execute).at_least(3) }

      it do
        expect(call.value!).to include(
          'twitter' => [],
          'facebook' => [],
          'instagram' => []
        )
      end
    end

    context 'when unexpected exception' do
      before do
        allow(RestClient::Request).to receive(:execute).and_raise('boom')
        allow(LogHelper).to receive(:exception).and_call_original
      end

      it { expect { call }.to raise_exception(SocialNetworks::FetchData::Unprocessable) }
    end
  end
end
