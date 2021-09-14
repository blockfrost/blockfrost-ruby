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

      context 'when passing combined params' do
        context 'when some params have a default value the same as passed' do
          it 'add only another params to return' do
            params_list = {
              count: 100,
              order: 'asc',
              from: 5,
              to: 105,
              parallel_requests: 20
            }
            params = Params.define_params(params_list, blockfrost.config)
            expect(params).to include(:from)
            expect(params).to include(:to)
            expect(params).to include(:parallel_requests)
            expect(params).not_to include(:count)
            expect(params).not_to include(:order)
          end
        end

        context 'when all params are not the same with default value' do
          it 'add all params to return' do
            params_list = {
              count: 50,
              order: 'desc',
              from: 5,
              to: 105,
              parallel_requests: 20
            }
            params = Params.define_params(params_list, blockfrost.config)
            expect(params).to include(:from)
            expect(params).to include(:to)
            expect(params).to include(:parallel_requests)
            expect(params).to include(:count)
            expect(params).to include(:order)
          end
        end
      end
    end
  end
end
