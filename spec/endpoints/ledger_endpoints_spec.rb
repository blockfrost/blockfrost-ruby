# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/ledger_endpoints'

RSpec.describe LedgerEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }
  let(:blockfrost_testnet) { Blockfrostruby::CardanoPreview.new(ENV['BF_TESTNET_PROJECT_ID']) }
  let(:blockfrost_testnet_invalid) { Blockfrostruby::CardanoPreview.new('invalid project_id') }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_genesis method' do
        it 'return status 200 and response body includes active_slots_coefficient' do
          response = blockfrost_mainnet.get_genesis
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:active_slots_coefficient)
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_genesis method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_genesis
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end

  context 'CardanoPreview object' do
    context 'with valid project_id' do
      context 'when calls get_genesis method' do
        it 'return status 200 and response body includes active_slots_coefficient' do
          response = blockfrost_testnet.get_genesis
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:active_slots_coefficient)
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_genesis method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_testnet_invalid.get_genesis
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
