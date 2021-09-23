# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/cardano/epochs_endpoints'

RSpec.describe EpochsEndpoints do
  let(:blockfrost_mainnet) { Blockfrostruby::CardanoMainNet.new(ENV['BF_MAINNET_PROJECT_ID']) }
  let(:blockfrost_mainnet_invalid) { Blockfrostruby::CardanoMainNet.new('invalid project_id') }

  let(:valid_pool_id) { 'pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy' }
  let(:valid_epoch_number) { '225' }
  let(:invalid_pool_id) { 'invalid_number' }
  let(:invalid_epoch_number) { 'invalid_number' }

  context 'CardanoMainNet object' do
    context 'with valid project_id' do
      context 'when calls get_latest_epoch method' do
        it 'returns status 200, response body includes epoch' do
          response = blockfrost_mainnet.get_block_latest
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:epoch)
        end
      end

      context 'when calls get_latest_epoch_parameters method' do
        it 'returns status 200, response body includes epoch' do
          response = blockfrost_mainnet.get_latest_epoch_parameters
          expect(response[:status]).to eq(200)
          expect(response[:body]).to include(:epoch)
        end
      end

      context 'when calls get_epoch method' do
        context 'with valid epoch number' do
          it 'returns status 200, response body includes epoch' do
            response = blockfrost_mainnet.get_epoch(valid_epoch_number)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(:epoch)
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_epoch(invalid_epoch_number)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_list_of_next_epochs method' do
        context 'with valid epoch number' do
          context 'without params' do
            it 'returns status 200, response body count > 1' do
              response = blockfrost_mainnet.get_list_of_next_epochs(valid_epoch_number)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200, response body count = 5' do
              response = blockfrost_mainnet.get_list_of_next_epochs(valid_epoch_number, { count: 5 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
            end
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_list_of_next_epochs(invalid_epoch_number)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_list_of_previous_epochs method' do
        context 'with valid epoch number' do
          context 'without params' do
            it 'returns status 200, response body count > 1' do
              response = blockfrost_mainnet.get_list_of_previous_epochs(valid_epoch_number)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200, response body count = 5' do
              response = blockfrost_mainnet.get_list_of_previous_epochs(valid_epoch_number, { count: 5 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
            end
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_list_of_previous_epochs(invalid_epoch_number)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_epoch_stakes method' do
        context 'with valid epoch number' do
          context 'without params' do
            it 'returns status 200, response body count > 1' do
              response = blockfrost_mainnet.get_epoch_stakes(valid_epoch_number)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200, response body count = 5' do
              response = blockfrost_mainnet.get_epoch_stakes(valid_epoch_number, { count: 5 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
            end
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_epoch_stakes(invalid_epoch_number)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_epoch_stakes_by_pool method' do
        context 'with valid epoch number and pool id' do
          context 'without params' do
            it 'returns status 200, response body count > 1' do
              response = blockfrost_mainnet.get_epoch_stakes_by_pool(valid_epoch_number, valid_pool_id)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200, response body count = 5' do
              response = blockfrost_mainnet.get_epoch_stakes_by_pool(valid_epoch_number, valid_pool_id, { count: 5 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
            end
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_epoch_stakes_by_pool(invalid_epoch_number, invalid_pool_id)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_epoch_blocks method' do
        context 'with valid epoch number' do
          context 'without params' do
            it 'returns status 200, response body count > 1' do
              response = blockfrost_mainnet.get_epoch_blocks(valid_epoch_number)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200, response body count = 5' do
              response = blockfrost_mainnet.get_epoch_blocks(valid_epoch_number, { count: 5 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
            end
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_epoch_blocks(invalid_epoch_number)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_epoch_blocks_by_pool method' do
        context 'with valid epoch number and pool id' do
          context 'without params' do
            it 'returns status 200, response body count > 1' do
              response = blockfrost_mainnet.get_epoch_blocks_by_pool(valid_epoch_number, valid_pool_id)
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to be > 1
            end
          end
          context 'with params { count: 5 }' do
            it 'returns status 200, response body count = 5' do
              response = blockfrost_mainnet.get_epoch_blocks_by_pool(valid_epoch_number, valid_pool_id, { count: 5 })
              expect(response[:status]).to eq(200)
              expect(response[:body].count).to eq(5)
            end
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_epoch_blocks_by_pool(invalid_epoch_number, invalid_pool_id)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end

      context 'when calls get_epoch_parameters method' do
        context 'with valid epoch number' do
          it 'returns status 200, response body includes epoch' do
            response = blockfrost_mainnet.get_epoch_parameters(valid_epoch_number)
            expect(response[:status]).to eq(200)
            expect(response[:body]).to include(:epoch)
          end
        end
        context 'with invalid epoch number' do
          it 'returns 403 status and body includes error' do
            response = blockfrost_mainnet_invalid.get_epoch_parameters(invalid_epoch_number)
            expect(response[:status]).to eq(403)
            expect(response[:body]).to include(:error)
          end
        end
      end
    end

    context 'with invalid project_id' do
      context 'when calls get_epoch method' do
        it 'returns 403 status and body includes error' do
          response = blockfrost_mainnet_invalid.get_epoch(valid_epoch_number)
          expect(response[:status]).to eq(403)
          expect(response[:body]).to include(:error)
        end
      end
    end
  end
end
