# frozen_string_literal: true

require_relative '../lib/blockfrostruby'
require_relative '../lib/blockfrostruby/request'
require_relative '../lib/blockfrostruby/constants'

RSpec.describe Request do
  let(:blockfrost) { Blockfrostruby::CardanoMainNet.new('project_id') }

  context 'when calls GET requests' do
    context 'when fetch single page' do 
      it 'add valid params to url, project_id and sdk_identificator to headers and send request' do
        params_list = { order: 'desc', count: 4, page: 2 }
        stub_cardano_success_request("/some_url?count=4&order=desc&page=2", '{"answer": true}', 'project_id')
        params = Params.define_params(params_list, blockfrost.config)
        response = Request.get_response("#{blockfrost.url}/some_url", blockfrost.project_id, params)
        expect(response).to eq({:status=>200, :body=>{:answer=>true}})
      end
    end

    context 'when fetch multiply pages' do
      it 'add valid params to url, project_id and sdk_identificator to headers and send request' do
        params_list = { order: 'desc', count: 4, from_page: 2, to_page: 4 }
        stub_cardano_success_request("/some_url?count=4&order=desc&page=2", '{"answer_page_2": true}', 'project_id')
        stub_cardano_success_request("/some_url?count=4&order=desc&page=3", '{"answer_page_3": true}', 'project_id')
        params = Params.define_params(params_list, blockfrost.config)
        response = Request.get_response("#{blockfrost.url}/some_url", blockfrost.project_id, params)
        expect(response).to eq({:status=>200, :body=>{:answer_page_2=>true, :answer_page_3=>true}})
      end
      
      
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