# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/metadata_endpoints'

RSpec.describe MetadataEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_label) { '1990' }
  let(:invalid_label) { 'invalid_label' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_transactions_metadata_labels method' do
        context 'without params' do
          it 'returns status 200, response body count > 1' do
            response = blockfrost_mainnet.get_transactions_metadata_labels
            expect(response[:status]).to eq(200)
            expect(response[:body].count).to be > 1
          end
        end
        context 'with params { count: 5 }' do
          it 'returns status 200, response body count = 5' do
            response = blockfrost_mainnet.get_transactions_metadata_labels({ count: 5 })
            expect(response[:status]).to eq(200)
            expect(response[:body].count).to eq(5)
          end
        end
      end

      context 'when calls get_transaction_metadata_content_in_json method' do
        context 'with valid label' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_transaction_metadata_content_in_json(valid_label)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_transaction_metadata_content_in_json(valid_label, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid label' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_transaction_metadata_content_in_json(invalid_label)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_metadata_content_in_cbor method' do
        context 'with valid label' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_transaction_metadata_content_in_cbor(valid_label)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_transaction_metadata_content_in_cbor(valid_label, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid label' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_transaction_metadata_content_in_cbor(invalid_label)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end
  end
end
