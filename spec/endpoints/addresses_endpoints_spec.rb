# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/addresses_endpoints'

RSpec.describe AddressesEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_address) { 'addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz' }
  let(:invalid_address) { 'invalid_adress' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_address method' do
        context 'with valid address' do
          it 'returns status 200, response body includes address, stake_address' do
            response = blockfrost_mainnet.get_specific_address(valid_address)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(address: valid_address)
            expect(response[:body]).to include(:stake_address)
          end
        end

        context 'with invalid address' do
          it 'returns status 400, response body includes error' do
            response = blockfrost_mainnet.get_specific_address(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_extended_address_info method' do
        context 'with valid address' do
          it 'returns status 200, response body includes address, amount, stake_address, type, script' do
            response = blockfrost_mainnet.get_extended_address_info(valid_address)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(address: valid_address)
            expect(response[:body]).to include(:amount)
            expect(response[:body]).to include(:stake_address)
            expect(response[:body]).to include(:type)
            expect(response[:body]).to include(:script)
          end
        end

        context 'with invalid address' do
          it 'returns status 400, response body includes error' do
            response = blockfrost_mainnet.get_extended_address_info(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_address_details method' do
        context 'with valid address' do
          it 'returns status 200, response body includes address' do
            response = blockfrost_mainnet.get_address_details(valid_address)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(address: valid_address)
          end
        end

        context 'with invalid address' do
          it 'returns status 400, response body includes error' do
            response = blockfrost_mainnet.get_address_details(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_address_utxos method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_address_utxos(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_address_utxos(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_address_utxos(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_address_utxos(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_address_transactions method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200, response body items count > 1, item includes tx_hash' do
              response = blockfrost_mainnet.get_address_transactions(valid_address)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
              expect(response[:body][0]).to include(:tx_hash)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_address_transactions(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_address_transactions(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_address_transactions(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_address method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_specific_address(valid_address)
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
