# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/pools_endpoints'

RSpec.describe PoolsEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_pool_id) { 'pool1llxh8l0h8g9ghz3nrzh7ndvev4x43vnk72nsemzm795vxqs6dp8' }
  let(:invalid_pool_id) { 'invalid_number' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_pools method' do
        context 'without params' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_pools
            expect(response[:status]).to eq(200)
          end
        end
        context 'with params { count: 5 }' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_pools({ count: 5 })
            expect(response[:status]).to eq(200)
          end
        end
      end

      context 'when calls get_list_of_retired_pools method' do
        context 'without params' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_list_of_retired_pools
            expect(response[:status]).to eq(200)
          end
        end
        context 'with params { count: 5 }' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_list_of_retired_pools({ count: 5 })
            expect(response[:status]).to eq(200)
          end
        end
      end

      context 'when calls get_list_of_retiring_pools method' do
        context 'without params' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_list_of_retiring_pools
            expect(response[:status]).to eq(200)
          end
        end
        context 'with params { count: 5 }' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_list_of_retiring_pools({ count: 5 })
            expect(response[:status]).to eq(200)
          end
        end
      end

      context 'when calls get_pool method' do
        context 'with valid pool_id' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_pool(valid_pool_id)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_pool_history method' do
        context 'with valid pool_id' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_history(valid_pool_id)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_history(valid_pool_id, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool_history(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_pool_metadata method' do
        context 'with valid pool_id' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_pool_metadata(valid_pool_id)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool_metadata(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_pool_relays method' do
        context 'with valid pool_id' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_pool_relays(valid_pool_id)
            expect(response[:status]).to eq(200)
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool_relays(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_pool_delegators method' do
        context 'with valid pool_id' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_delegators(valid_pool_id)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_delegators(valid_pool_id, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool_delegators(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_pool_blocks method' do
        context 'with valid pool_id' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_blocks(valid_pool_id)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_blocks(valid_pool_id, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool_blocks(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_pool_updates method' do
        context 'with valid pool_id' do
          context 'without params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_updates(valid_pool_id)
              expect(response[:status]).to eq(200)
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_pool_updates(valid_pool_id, { count: 5 })
              expect(response[:status]).to eq(200)
            end
          end
        end
        context 'with invalid pool_id' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_pool_updates(invalid_pool_id)
            expect(response[:status]).to eq(400)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end
  end
end
