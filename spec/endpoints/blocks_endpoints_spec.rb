# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/blocks_endpoints'

RSpec.describe BlocksEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_hash_or_number) { '5ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a' }
  let(:valid_slot_number) { '30895909' }
  let(:valid_epoch_number) { '219' }
  let(:invalid_hash_or_number) { 'invalid_number' }
  let(:invalid_slot_number) { 'invalid_number' }
  let(:invalid_epoch_number) { 'invalid_number' }
  
  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_block_latest method' do
        it 'returns status 200, response body includes hash' do
          response = blockfrost_mainnet.get_block_latest
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:hash)
        end
      end
   
      context 'when calls get_block_latest_transactions method' do
        context 'without params' do
          it 'returns status 200, response body item count > 1' do
            response = blockfrost_mainnet.get_block_latest_transactions
            expect(response[:status]).to eq(200)
            expect(response[:body].count).to be > 1
          end
        end
        context 'with params' do
          it 'returns status 200, response body item count = 3' do
            response = blockfrost_mainnet.get_block_latest_transactions({ count: 3, page: 2 })
            expect(response[:status]).to eq(200)
            expect(response[:body].count).to eq 3
          end
        end
      end

      context 'when calls get_block method' do
        context 'with valid hash_or_number' do
          it 'returns status 200, response body item include hash' do
            response = blockfrost_mainnet.get_block(valid_hash_or_number)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(:hash)
          end
        end
        context 'with invalid hash_or_number' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_block(invalid_hash_or_number)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end


    context 'with invalid project_id' do
      context 'when calls get_specific_asset method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_specific_asset(valid_asset)
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
