# frozen_string_literal: true

require_relative '../lib/blockfrostruby.rb'
require_relative '../lib/blockfrostruby/validator.rb'
require_relative '../lib/blockfrostruby/constants.rb'

RSpec.describe Validator do
  context 'when creating a Blockfrost object' do
    context 'with invalid use_asc_order_as_default' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: 1 })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: 'a' })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: :symbol })}
        .to raise_error(ArgumentError)
        # expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: nil })}
        # .to raise_error(ArgumentError)
      end
    end

    context 'with invalid parallel_requests' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: MAX_NUMBER_OF_PARALLEL_REQUESTS + 1  })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: 'a' })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: -1 })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: :symbol })}
        .to raise_error(ArgumentError)
      end
    end

    context 'with invalid default_count_per_page' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: MAX_COUNT_PER_PAGE + 1 })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: 'a' })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: -1 })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: :symbol })}
        .to raise_error(ArgumentError)
      end
    end

    context 'with invalid sleep_between_retries_ms' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: 'a' })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: -1 })}
        .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: :symbol })}
        .to raise_error(ArgumentError)
      end
    end

    # context 'with all valid params' do
    # end
  end

  # context 'when specifying params for requests' do
  # end
end

