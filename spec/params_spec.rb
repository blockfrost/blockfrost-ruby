# frozen_string_literal: true

require_relative '../lib/blockfrostruby'
require_relative '../lib/blockfrostruby/params'
require_relative '../lib/blockfrostruby/constants'
require_relative '../lib/blockfrostruby/configuration'

RSpec.describe Params do
  let(:blockfrost) { Blockfrostruby::CardanoMainNet.new('project_id') }
  
  context 'when passing allowed params' do 
  
  end

  context 'when passing not allowed params' do 
    it 'don\'t add this params to the return' do 
      params = Params.define_params({ some_param: 5 }, blockfrost.config)
      expect(params).not_to include(:some_param) 
    end
  end
end


  # allow to add permitted params
  # disallow to add not-permitted params

  # returns value from config if no passed
  # checks that it use value from config
  # checks that it will not add params to request
  
  

  # REQUEST - ADD ONLY ALLOWED API PARAMS TO THE REQUEST
