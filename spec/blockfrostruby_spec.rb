# frozen_string_literal: true

require_relative '../lib/blockfrostruby.rb'
require_relative '../lib/blockfrostruby/constants.rb'

RSpec.describe Blockfrostruby do
  it 'has a version number' do
    expect(Blockfrostruby::VERSION).not_to be nil
  end
end

RSpec.describe Blockfrostruby::CardanoMainNet do
  context 'with project_id' do
    context 'without any params' do

      subject { Blockfrostruby::CardanoMainNet.new('project_id') }

      it 'creates a CardanoMainNet instance' do
        expect(subject).to be_a(Blockfrostruby::CardanoMainNet)
      end

      it 'instanse has a passed project_id' do
        expect(subject.project_id).to eq('project_id')
      end

      it 'instanse has CardanoMainNet URL from constants' do
        expect(subject.url).to eq(CARDANO_MAINNET_URL)
      end

      it 'instanse has config params' do
        expect(subject.config).not_to be_empty
      end
    end

    context 'with valid params' do
      config = { 
        use_asc_order_as_default: false,
        parallel_requests: 15,
        default_count_per_page: 35,
        sleep_between_retries_ms: 125
      }

      subject { Blockfrostruby::CardanoMainNet.new('project_id', config) }

      it 'creates a CardanoMainNet instance' do
        expect(subject).to be_a(Blockfrostruby::CardanoMainNet)
      end

      it 'instanse has a passed project_id' do
        expect(subject.project_id).to eq('project_id')
      end

      it 'instanse has CardanoMainNet URL from constants' do
        expect(subject.url).to eq(CARDANO_MAINNET_URL)
      end

      it 'instanse has params specified by user' do
        expect(subject.config).to eq(config)
      end
    end

    context 'with invalid params' do
      config = { 
        use_asc_order_as_default: 10,
        parallel_requests: false,
        default_count_per_page: 'any word',
        sleep_between_retries_ms: :symbol
      }
      
      it 'raise an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', config)}.to raise_error(ArgumentError)
      end
    end

    context 'without project_id' do
      it 'raise an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new()}.to raise_error(ArgumentError)
      end
    end
  end
end

  # describe CardanoTestNet do
  # end

  # describe IPFS do
  # end
#end
