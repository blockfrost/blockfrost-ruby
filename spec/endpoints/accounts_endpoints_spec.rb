# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/accounts_endpoints'

RSpec.describe HealthEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }
  let(:blockfrost_testnet) { Blockfrostruby::CardanoTestNet.new(ENV['BF_TESTNET_PROJECT_ID']) }
  let(:blockfrost_testnet_invalid) { Blockfrostruby::CardanoTestNet.new('invalid project_id') }
  
  let(:valid_address) { "stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc" }
  let(:invalid_address) { "invalid_adress" }
  
  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_account_address method' do
        context 'with valid address' do 
          it 'returns status 200, response body includes stake_address, active and pool_id' do
            response = blockfrost_mainnet.get_account_address(valid_address)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(:stake_address => valid_address)
            expect(response[:body]).to include(:active, :pool_id)
          end
        end

        context 'with invalid address' do 
          it 'returns status 400, response body includes error' do
            response = blockfrost_mainnet.get_account_address(invalid_address)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
            # expect(response[:body]).to include(:active, :active_epoch, :pool_id)
          end
        end
      end

      # context 'when calls get_root method' do
      #   it 'return status 200 and response includes an url' do
      #     response = blockfrost_mainnet.get_root
      #     expect(response[:status]).to eq(200)
      #     expect(response[:body]).to include(:url =>"https://blockfrost.io/")
      #   end
      # end

      # context 'when calls get_health_clock method' do
      #   it 'return status 200 and response includes a server time' do
      #     response = blockfrost_mainnet.get_health_clock
      #     expect(response[:status]).to eq(200)
      #     expect(response[:body]).to include(:server_time)
      #   end
      # end
    end

    context 'with invalid project_id' do 
      # context 'when calls get_health method' do
      #   it 'returns 403 status and body includes error' do 
      #     response = blockfrost_mainnet_invalid.get_health
      #     expect(response[:status]).to eq(403)
      #     expect(response[:body]).to include(:error)
      #   end
      # end
    end
  end

  context 'CardanoTestNet object' do
    context 'with valid project_id' do
      context 'when calls get_health method' do
        # it 'return status 200 and is_healthy => true' do
        #   response = blockfrost_testnet.get_health
        #   expect(response[:status]).to eq(200)
        #   expect(response[:body]).to eq({ is_healthy: true })
        # end
      end

      context 'when calls get_root method' do
        # it 'return status 200 and response includes an url' do
        #   response = blockfrost_testnet.get_root
        #   expect(response[:status]).to eq(200)
        #   expect(response[:body]).to include(:url =>"https://blockfrost.io/")
        # end
      end

      context 'when calls get_health_clock method' do
        # it 'return status 200 and response includes a server time' do
        #   response = blockfrost_testnet.get_health_clock
        #   expect(response[:status]).to eq(200)
        #   expect(response[:body]).to include(:server_time)
        # end
      end
    end

    context 'with invalid project_id' do 
      context 'when calls get_health method' do
        # it 'returns 403 status and body includes error' do 
        #   response = blockfrost_testnet_invalid.get_health
        #   expect(response[:status]).to eq(403)
        #   expect(response[:body]).to include(:error)
        # end
      end
    end
  end
end
