# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/transactions_endpoints'

RSpec.describe TransactionsEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_hash) { 'f6780212de5df00d10d929d0ca33dc2ff60cc57f38bd2b3cb3b2dea36f0c20b6' }
  let(:invalid_hash) { 'invalid_number' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_transaction method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_utxos method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_utxos(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_utxos(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_stakes method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_stakes(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_stakes(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_delegations method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_delegations(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_delegations(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_withdrawals method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_withdrawals(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_withdrawals(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_mirs method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_mirs(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_mirs(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_pool_updates method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_pool_updates(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_pool_updates(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_pool_retires method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_pool_retires(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_pool_retires(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_metadata method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_metadata(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_metadata(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_transaction_metadata_in_cbor method' do
        context 'with valid hash' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_transaction_metadata_in_cbor(valid_hash)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid hash' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_transaction_metadata_in_cbor(invalid_hash)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end
  end
end
