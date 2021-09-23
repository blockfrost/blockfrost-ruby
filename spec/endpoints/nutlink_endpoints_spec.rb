# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/nutlink_endpoints'

RSpec.describe NutlinkEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_address) { 'addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz' }
  let(:invalid_address) { 'invalid_number' }
  let(:valid_ticker) { 'valid_ticker' }
  let(:invalid_ticker) { 'invalid_number' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_address_metadata_list method' do
        context 'with valid address' do
          it 'returns status 200' do
            skip 'Return 404 now'
            response = blockfrost_mainnet.get_address_metadata_list(valid_address)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid address' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_address_metadata_list(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_address_metadata_tickers_list method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200' do
              skip 'Return 404 now'
              response = blockfrost_mainnet.get_address_metadata_tickers_list(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              skip 'Return 404 now'
              response = blockfrost_mainnet.get_address_metadata_tickers_list(valid_address, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid address' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_address_metadata_tickers_list(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_ticker_records_by_address method' do
        context 'with valid address and ticker' do
          context 'without params' do
            it 'returns status 200' do
              skip 'Return 404 now'
              response = blockfrost_mainnet.get_ticker_records_by_address(valid_address, valid_ticker)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              skip 'Return 404 now'
              response = blockfrost_mainnet.get_ticker_records_by_address(valid_address, valid_ticker, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid address' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_ticker_records_by_address(invalid_address, invalid_ticker)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_ticker_records method' do
        context 'with valid address and ticker' do
          context 'without params' do
            it 'returns status 200' do
              skip 'Return 404 now'
              response = blockfrost_mainnet.get_ticker_records(valid_ticker)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              skip 'Return 404 now'
              response = blockfrost_mainnet.get_ticker_records(valid_ticker, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid address' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_ticker_records(invalid_ticker)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end
  end
end
