# frozen_string_literal: true

require_relative '../lib/blockfrostruby'
require_relative '../lib/blockfrostruby/params'
require_relative '../lib/blockfrostruby/constants'
require_relative '../lib/blockfrostruby/configuration'

RSpec.describe Params do
  let(:blockfrost) { Blockfrostruby::CardanoMainNet.new('project_id') }

  context 'when passing not allowed param' do
    it 'don\'t add this param to the return' do
      params = Params.define_params({ some_param: 5 }, blockfrost.config)
      expect(params).not_to include(:some_param)
    end
  end

  context 'when passing allowed params' do
    context 'when params has default value in API (ex. count=100)' do
      context 'when params not the same as default values in API' do
        it 'add passed order to return' do
          params = Params.define_params({ order: 'desc' }, blockfrost.config)
          expect(params).to include(:order)
        end

        it 'add passed count to return' do
          params = Params.define_params({ count: 14 }, blockfrost.config)
          expect(params).to include(:count)
        end
      end

      context 'when params are the same as default values in API' do
        it 'doesn\'t add passed order to return' do
          params = Params.define_params({ order: 'asc' }, blockfrost.config)
          expect(params).not_to include(:order)
        end

        it 'doesn\'t add passed count to return' do
          params = Params.define_params({ count: 100 }, blockfrost.config)
          expect(params).not_to include(:count)
        end
      end
    end

    context 'when params has no default value in API' do 
      context 'when passing single params' do 
        it 'adds \'page\' param to return' do
          params = Params.define_params({ page: 10 }, blockfrost.config)
          expect(params).to include(:page)
          expect(params[:page]).to eq(10)
        end
        
        it 'adds \'from\' param to return' do
          params = Params.define_params({ from: 10 }, blockfrost.config)
          expect(params).to include(:from)
          expect(params[:from]).to eq(10)
        end

        it 'adds \'to\' param to return' do
          params = Params.define_params({ to: 10 }, blockfrost.config)
          expect(params).to include(:to)
          expect(params[:to]).to eq(10)
        end

        it 'adds \'from_page\' param to return' do
          params = Params.define_params({ from_page: 10 }, blockfrost.config)
          expect(params).to include(:from_page)
          expect(params[:from_page]).to eq(10)
        end

        it 'adds \'to_page\' param to return' do
          # to_page cannot be specified without from_page
          params = Params.define_params({ from_page: 1, to_page: 10 }, blockfrost.config)
          expect(params).to include(:to_page)
          expect(params[:to_page]).to eq(10)
        end

        it 'adds \'parallel_requests\' param to return' do
          params = Params.define_params({ parallel_requests: 10 }, blockfrost.config)
          expect(params).to include(:parallel_requests)
          expect(params[:parallel_requests]).to eq(10)
        end

        it 'adds \'sleep_between_retries_ms\' param to return' do
          params = Params.define_params({ sleep_between_retries_ms: 10 }, blockfrost.config)
          expect(params).to include(:sleep_between_retries_ms)
          expect(params[:sleep_between_retries_ms]).to eq(10)
        end
      end
    end
  end
end

# allow to add permitted params
# disallow to add not-permitted params

# returns value from config if no passed
# checks that it use value from config
# checks that it will not add params to request

# REQUEST - ADD ONLY ALLOWED API PARAMS TO THE REQUEST
