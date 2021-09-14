# frozen_string_literal: true

require_relative '../lib/blockfrostruby'
require_relative '../lib/blockfrostruby/request'
require_relative '../lib/blockfrostruby/constants'

RSpec.describe Request do
  context 'when calls GET requests' do
    context 'when fetch single page' do 

      it 'add valid params to url' do 
      end

      it 'add project_id to headers' do 
      end

      it 'add sdk_identificator to headers' do 
      end

      it 'send request to the API' do 
      end

      it 'format JSON response' do 
      end

      it 'correctly handling not-JSON response' do
      end

      it 'format response with status and body' do 
      end

    end

    context 'when fetch multiply pages' do
      # add only valid params to url, not include from_page and to_page
      # able to stop sending request when the page will be empty
      # able to stop without specifying to_page
      # able to show the right error messages when handling the limit 
      # sort the array of results in the right manner 
    end

  end

  context 'when calls POST requests' do 
  end

end


  # context 'with valid params' do
  #   it 'not raises an ArgumentError' do
  #     stub_cardano_success_request('/blocks/latest/txs?count=80&page=6', '{"answer": true}', 'project_id')
  #     stub_cardano_success_request('/blocks/latest/txs?count=80&page=5', '{"answer": true}', 'project_id')
  #     stub_cardano_success_request('/blocks/latest/txs?count=80&page=4', '{"answer": true}', 'project_id')
  #     stub_cardano_success_request('/blocks/latest/txs?count=80&page=3', '{"answer": true}', 'project_id')

  #     params = { order: 'asc', count: 80, from_page: 3, to_page: 6,
  #                 parallel_requests: 5, sleep_between_retries_ms: 200 }
  #     expect { blockfrost.get_block_latest_transactions(params) }.not_to raise_error(ArgumentError)
  #   end
  # end