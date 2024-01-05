# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/nutlink_endpoints'

RSpec.describe NutlinkEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }

  let(:valid_address) { 'addr1q85yx2w7ragn5sx6umgmtjpc3865s9sg59sz4rrh6f90kgwfwlzu3w8ttacqg89mkdgwshwnplj5c5n9f8dhp0h55q2q7qm63t' }
  let(:invalid_address) { 'invalid' }
  let(:valid_ticker) { 'ADABTC' }
  let(:invalid_ticker) { 'invalid' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_address_metadata_list method' do
        context 'with valid address' do
          it 'returns status 200' do
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
              response = blockfrost_mainnet.get_address_metadata_tickers_list(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
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
              response = blockfrost_mainnet.get_ticker_records_by_address(valid_address, valid_ticker)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
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
              response = blockfrost_mainnet.get_ticker_records(valid_ticker)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
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
