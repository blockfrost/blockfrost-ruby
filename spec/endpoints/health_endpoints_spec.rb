# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/health_endpoints'

RSpec.describe HealthEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_health method' do
        it 'return status 200 and is_healthy => true' do
          response = blockfrost_mainnet.get_health
          expect(response[:status]).to eq(200)
          expect(response[:body]).to eq({ is_healthy: true })
        end
      end
    end
  end
end
