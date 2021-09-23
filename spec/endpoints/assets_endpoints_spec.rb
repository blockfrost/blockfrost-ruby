# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/assets_endpoints'

RSpec.describe AssetsEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_asset) { '81791e9e2b5929574039c38020374c753a548ef84bd7eaef8c908bdf43617264616e6f4b6f6d626174533154323541303035' }
  let(:invalid_asset) { 'invalid_asset' }
  let(:valid_policy_id) { '476039a0949cf0b22f6a800f56780184c44533887ca6e821007840c3' } # TODO: change
  let(:invalid_policy_id) { 'invalid_policy_id' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_assets method' do
        context 'without params' do
          it 'returns status 200, response body items count > 1, item includes asset' do
            response = blockfrost_mainnet.get_assets
            expect(response[:status]).to eq(200)
            expect(response[:body].count).to be > 1
            expect(response[:body][0]).to include(:asset)
          end
        end

        context 'with params' do
          it 'returns status 200, response body items count = 5, item includes asset' do
            response = blockfrost_mainnet.get_assets({ count: 5, page: 2 })
            expect(response[:status]).to eq(200)
            expect(response[:body].count).to eq 5
            expect(response[:body][0]).to include(:asset)
          end
        end
      end

      context 'when calls get_specific_asset method' do
        context 'with valid asset' do
          it 'returns status 200, response body includes asset' do
            response = blockfrost_mainnet.get_specific_asset(valid_asset)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(:asset)
          end
        end

        context 'with invalid asset' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_specific_asset(invalid_asset)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_asset_history method' do
        context 'with valid asset' do
          context 'without params' do
            it 'returns status 200, response body item includes tx_hash' do
              response = blockfrost_mainnet.get_asset_history(valid_asset)
              expect(response[:status]).to eq(200)
              expect(response[:body][0]).to include(:tx_hash)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_asset_history(valid_asset, { count: 3, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid asset' do
          context 'without params' do
            it 'returns status 404, response body includes error' do
              response = blockfrost_mainnet.get_asset_history(invalid_asset)
              expect(response[:status]).to eq(404)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 404, response body includes error' do
              response = blockfrost_mainnet.get_asset_history(invalid_asset, { count: 7, page: 3 })
              expect(response[:status]).to eq(404)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_asset_transactions method' do
        context 'with valid asset' do
          context 'without params' do
            it 'returns status 200, response body item includes tx_hash' do
              response = blockfrost_mainnet.get_asset_transactions(valid_asset)
              expect(response[:status]).to eq(200)
              expect(response[:body][0]).to include(:tx_hash)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_asset_transactions(valid_asset, { count: 3, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid asset' do
          context 'without params' do
            it 'returns status 404, response body includes error' do
              response = blockfrost_mainnet.get_asset_transactions(invalid_asset)
              expect(response[:status]).to eq(404)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 404, response body includes error' do
              response = blockfrost_mainnet.get_asset_transactions(invalid_asset, { count: 7, page: 3 })
              expect(response[:status]).to eq(404)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end

      context 'when calls get_asset_addresses method' do
        context 'with valid asset' do
          context 'without params' do
            it 'returns status 200, response body item includes address' do
              response = blockfrost_mainnet.get_asset_addresses(valid_asset)
              expect(response[:status]).to eq(200)
              expect(response[:body][0]).to include(:address)
            end
          end
          context 'with params' do
            it 'returns status 200' do
              response = blockfrost_mainnet.get_asset_addresses(valid_asset, { count: 3, page: 2 })
              expect(response[:status]).to eq(200)
            end
          end
        end

        context 'with invalid asset' do
          context 'without params' do
            it 'returns status 404, response body includes error' do
              response = blockfrost_mainnet.get_asset_addresses(invalid_asset)
              expect(response[:status]).to eq(404)
              expect(response[:body]).to include(:error)
            end
          end
          context 'with params' do
            it 'returns status 404, response body includes error' do
              response = blockfrost_mainnet.get_asset_addresses(invalid_asset, { count: 7, page: 3 })
              expect(response[:status]).to eq(404)
              expect(response[:body]).to include(:error)
            end
          end
        end
      end
    end

    context 'when calls get_assets_of_policy method' do
      context 'with valid policy_id' do
        context 'without params' do
          it 'returns not_nil status' do
            response = blockfrost_mainnet.get_assets_of_policy(valid_policy_id)
            expect(response[:status]).not_to be_nil
          end
        end
        context 'with params' do
          it 'returns status 200' do
            response = blockfrost_mainnet.get_assets_of_policy(valid_policy_id, { count: 3, page: 2 })
            expect(response[:status]).not_to be_nil
          end
        end
      end

      context 'with invalid policy_id' do
        context 'without params' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_assets_of_policy(invalid_policy_id)
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
        context 'with params' do
          it 'returns status 404, response body includes error' do
            response = blockfrost_mainnet.get_assets_of_policy(invalid_policy_id, { count: 7, page: 3 })
            expect(response[:status]).to eq(404)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_specific_asset method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_specific_asset(valid_asset)
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
