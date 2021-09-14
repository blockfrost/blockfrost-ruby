# frozen_string_literal: true

require_relative '../lib/blockfrostruby'
require_relative '../lib/blockfrostruby/params'
require_relative '../lib/blockfrostruby/constants'
require_relative '../lib/blockfrostruby/configuration'

RSpec.describe Params do
  let(:blockfrost) { Blockfrostruby::CardanoMainNet.new('project_id') }

  context 'when passing not allowed params' do
    it 'don\'t add this params to the return' do
      params = Params.define_params({ some_param: 5 }, blockfrost.config)
      expect(params).not_to include(:some_param)
    end
  end

  context 'when passing allowed params' do
    context 'when params has default value in API (ex. count=100)' do
      context 'when params not the same as default values in API' do
        it 'add order to return' do
          params = Params.define_params({ order: 'desc' }, blockfrost.config)
          expect(params).to include(:order)
        end

        it 'add count to return' do
          params = Params.define_params({ count: 14 }, blockfrost.config)
          expect(params).to include(:count)
        end
      end

      context 'when params are the same as default values in API' do
        it 'doesn\'t add order to return' do
          params = Params.define_params({ order: 'asc' }, blockfrost.config)
          expect(params).not_to include(:order)
        end

        it 'doesn\'t add count to return' do
          params = Params.define_params({ count: 100 }, blockfrost.config)
          expect(params).not_to include(:count)
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
