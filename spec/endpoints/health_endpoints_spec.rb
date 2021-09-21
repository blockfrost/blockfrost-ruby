# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/health_endpoints'

RSpec.describe HealthEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_health method' do
        it 'return status 200 and is_healthy => true' do
          response = blockfrost_mainnet.get_health
          expect(response[:status]).to eq(200)
          expect(response[:body]).to eq({ is_healthy: true })
        end
      end

      context 'when calls get_root method' do
        it 'return status 200 and response includes an url' do
          response = blockfrost_mainnet.get_root
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:url =>"https://blockfrost.io/")
        end
      end

      context 'when calls get_health_clock method' do
        it 'return status 200 and response includes a server time' do
          response = blockfrost_mainnet.get_health_clock
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:server_time)
        end
      end
    end

    context 'with invalid project_id' do 
      context 'when calls get_health method' do
        it 'returns 403 status and body includes error' do 
          response = blockfrost_mainnet_invalid.get_health
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
