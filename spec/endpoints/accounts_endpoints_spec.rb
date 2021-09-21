# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/accounts_endpoints'

RSpec.describe HealthEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_address) { 'stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc' }
  let(:invalid_address) { 'invalid_adress' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_account_address method' do
        context 'with valid address' do
          it 'returns status 200, response body includes stake_address, active and pool_id' do
            response = blockfrost_mainnet.get_account_address(valid_address)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(stake_address: valid_address)
            expect(response[:body]).to include(:active, :pool_id)
          end
        end

        context 'with invalid address' do
          it 'returns status 400, response body includes error' do
            response = blockfrost_mainnet.get_account_address(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_account_rewards method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_rewards(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_rewards(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_rewards(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_rewards(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_history method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200, response body items count > 1 and item includes pool_id' do
              response = blockfrost_mainnet.get_account_history(valid_address)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
              expect(response[:body][0]).to include(:pool_id)
            end
          end
          context 'with params' do
            it 'returns status 200, response body items count = 10 and item includes pool_id' do
              response = blockfrost_mainnet.get_account_history(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq 10
              expect(response[:body][0]).to include(:pool_id)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_history(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_history(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_delegations method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200, response body item includes pool_id' do
              response = blockfrost_mainnet.get_account_delegations(valid_address)
              expect(response[:status]).to eq(200)
              expect(response[:body][0]).to include(:pool_id)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_delegations(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_delegations(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_delegations(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_registrations method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200, response body item includes tx_hash' do
              response = blockfrost_mainnet.get_account_registrations(valid_address)
              expect(response[:status]).to eq(200)
              expect(response[:body][0]).to include(:tx_hash)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_registrations(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_registrations(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_registrations(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_withdrawals method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_withdrawals(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_withdrawals(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_withdrawals(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_withdrawals(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_mirs method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_mirs(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_mirs(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_mirs(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_mirs(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_assosiated_addresses method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200, response body items count > 1, item includes address' do
              response = blockfrost_mainnet.get_account_assosiated_addresses(valid_address)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
              expect(response[:body][0]).to include(:address)
            end
          end
          context 'with params' do
            it 'returns status 200, response body items count = 5, item includes address' do
              response = blockfrost_mainnet.get_account_assosiated_addresses(valid_address, { count: 5, page: 2 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
              expect(response[:body][0]).to include(:address)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_assosiated_addresses(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_assosiated_addresses(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_account_addresses_assets method' do
        context 'with valid address' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_addresses_assets(valid_address)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_account_addresses_assets(valid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid address' do
          context 'without params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_addresses_assets(invalid_address)
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 400, response body includes error' do
              response = blockfrost_mainnet.get_account_addresses_assets(invalid_address, { count: 10, page: 2 })
              expect(response[:status]).to eq(400)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_account_address method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_account_address(valid_address)
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
