# frozen_string_literal: true

require_relative '../../lib/blockfrost-ruby'
require_relative '../../lib/blockfrostruby/constants'
require_relative '../../lib/blockfrostruby/endpoints/ipfs/ipfs_endpoints'

RSpec.describe IPFSEndpoints do
  let(:blockfrost_ipfs) { Blockfrostruby::IPFS.new(ENV['BF_IPFS_PROJECT_ID']) }
  let(:blockfrost_ipfs_invalid) { Blockfrostruby::IPFS.new('invalid project_id') }

  let(:valid_hash) { 'f6780212de5df00d10d929d0ca33dc2ff60cc57f38bd2b3cb3b2dea36f0c20b6' }
  let(:invalid_hash) { 'invalid_number' }

  context 'IPFS object' do
    context 'with valid project_id' do
      context 'when calls get_localstorage_pinned_objects_list method' do
        context 'without params' do
          it 'returns status 200' do
            response = blockfrost_ipfs.get_localstorage_pinned_objects_list
            expect(response[:status]).to eq(200)
          end
        end
        context 'with params { count: 2 }' do
          it 'returns status 200' do
            response = blockfrost_ipfs.get_localstorage_pinned_objects_list({ count: 2 })
            expect(response[:status]).to eq(200)
          end
        end
      end

      # ORDER MATTERS
      # RUN ONLY WHOLE CONTEXT

      context 'when calls add, pin, get and remove object step-by-step' do
        ipfs_path = ''
        context 'when calls add_a_file method' do
          it 'returns status 200' do
            puts "\n" * 3
            puts Dir.pwd
            puts "\n" * 3
            response = blockfrost_ipfs.add_a_file('./Gemfile')
            expect(response[:status]).to eq(200)
            ipfs_path = response[:body][:ipfs_hash]
            puts "\n" * 3
            puts ipfs_path
            puts "\n" * 3
          end
        end
        context 'when calls pin_an_object method' do
          it 'returns status 200' do
            sleep 10
            response = blockfrost_ipfs.pin_an_object(ipfs_path)
            expect(response[:status]).to eq(200)
          end
        end
        context 'when calls get_localstorage_pinned_object method' do
          it 'returns status 200 and response body ipfs hash is eq path from add_a_file' do
            sleep 10 # To make sure that pin_object method finished work
            response = blockfrost_ipfs.get_localstorage_pinned_object(ipfs_path)
            puts "\n" * 3
            puts response
            puts "\n" * 3 
            expect(response[:status]).to eq(200)
            expect(response[:body][:ipfs_hash]).to eq(ipfs_path)
          end
        end
        context 'when calls remove pinned_object method' do
          it 'returns status 200 and response body ipfs hash is eq path from add_a_file' do
            response = blockfrost_ipfs.remove_pinned_object(ipfs_path)
            expect(response[:status]).to eq(200)
            expect(response[:body][:ipfs_hash]).to eq(ipfs_path)
          end
        end
        context 'when calls get_localstorage_pinned_objects_list method' do
          it 'returns status 200 and response body doesn\'t include hash from add a file' do
            sleep 10 # To make sure that remove_pinned_object method finished work
            response = blockfrost_ipfs.get_localstorage_pinned_objects_list
            expect(response[:status]).to eq(200)
            pinned_hashes = response[:body].map { |el| el[:ipfs_hash] }
            expect(pinned_hashes).not_to include(ipfs_path)
          end
        end
      end
    end
  end
end
