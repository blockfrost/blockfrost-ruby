# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/metrics_endpoints'

RSpec.describe NetworkEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }
  let(:blockfrost_testnet) { Blockfrostruby::CardanoTestNet.new(ENV['BF_TESTNET_PROJECT_ID']) }
  let(:blockfrost_testnet_invalid) { Blockfrostruby::CardanoTestNet.new('invalid project_id') }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_network method' do
        it 'return status 200' do
          response = blockfrost_mainnet.get_network
          expect(response[:status]).to eq(200)
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_network method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_network
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end

  context 'CardanoTestNet object' do
    context 'with valid project_id' do
      context 'when calls get_network method' do
        it 'return status 200' do
          response = blockfrost_testnet.get_network
          expect(response[:status]).to eq(200)
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_network method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_testnet_invalid.get_network
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
