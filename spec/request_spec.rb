# frozen_string_literal: true
# # frozen_string_literal: true

# require_relative '../lib/blockfrost-ruby'
# require_relative '../lib/blockfrostruby/request'
# require_relative '../lib/blockfrostruby/constants'

# RSpec.describe Request do
#   let(:blockfrost) { Blockfrostruby::CardanoMainNet.new('project_id') }
#   before do
#     stub_cardano_success_request('/some_url?count=4&order=desc&page=2', '{"answer2": true}', 'project_id')
#     stub_cardano_success_request('/some_url?count=4&order=desc&page=3', '{"answer3": true}', 'project_id')
#     stub_cardano_success_request('/some_url?count=4&order=desc&page=4', '{"answer4": true}', 'project_id')
#     stub_cardano_success_request('/some_url?count=4&order=desc&page=5', '{"answer5": true}', 'project_id')
#   end

#   context 'when calls GET requests' do
#     context 'when fetch single page' do
#       it 'add valid params to url, project_id and sdk_identificator to headers, send request and format answer' do
#         params_list = { order: 'desc', count: 4, page: 2 }
#         params = Params.define_params(params_list, blockfrost.config)
#         response = Request.get_response("#{blockfrost.url}/some_url", blockfrost.project_id, params)
#         expect(response).to eq({ status: 200, body: { answer2: true } })
#       end
#     end

#     context 'when fetch multiply pages' do
#       it 'add valid params to url, project_id and sdk_identificator to headers and send request' do
#         params_list = { order: 'desc', count: 4, from_page: 2, to_page: 5 }
#         params = Params.define_params(params_list, blockfrost.config)
#         response = Request.get_response("#{blockfrost.url}/some_url", blockfrost.project_id, params)
#         expect(response).not_to be_empty
#         # RSPEC doesn't support adequate multithread testing.
#         # So in test running we will always get something like:
#         # ['{"answer2": true}', '{"answer2": true}', '{"answer2": true}']
#         # But the real execution has another behavior.
#         # Please double check multithreading running with manual tests.
#       end
#     end
#   end
# end
