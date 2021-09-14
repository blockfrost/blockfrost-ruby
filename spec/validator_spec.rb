# frozen_string_literal: true

require_relative '../lib/blockfrostruby'
require_relative '../lib/blockfrostruby/validator'
require_relative '../lib/blockfrostruby/constants'

RSpec.describe Validator do
  context 'when creating a Blockfrost object' do
    context 'with invalid use_asc_order_as_default' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: 1 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: 'a' }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { use_asc_order_as_default: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid default_count_per_page' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: MAX_COUNT_PER_PAGE + 1 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: 'a' }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: -1 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { default_count_per_page: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid parallel_requests' do
      it 'raises an ArgumentError' do
        expect do
          Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: MAX_NUMBER_OF_PARALLEL_REQUESTS + 1 })
        end
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: 'a' }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: -1 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { parallel_requests: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid sleep_between_retries_ms' do
      it 'raises an ArgumentError' do
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: 'a' }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: -1 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { Blockfrostruby::CardanoMainNet.new('project_id', { sleep_between_retries_ms: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with valid params' do
      it 'not raises an ArgumentError' do
        config = {
          use_asc_order_as_default: false,
          parallel_requests: 15,
          default_count_per_page: 35,
          sleep_between_retries_ms: 125
        }
        expect { Blockfrostruby::CardanoMainNet.new('project_id', config) }
          .not_to raise_error(ArgumentError)
      end
    end
  end

  context 'when specifying params for requests' do
    let(:blockfrost) { Blockfrostruby::CardanoMainNet.new('project_id') }

    context 'with invalid order' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ order: -1 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ order: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ order: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid count' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ count: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ count: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ count: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ count: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid page' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ page: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ page: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ page: MAX_COUNT_PER_PAGE + 1 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ page: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ page: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid from' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ from: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ from: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ from: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ from: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid to' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ to: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ to: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ to: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ to: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid from_page' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ from_page: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ from_page: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ from_page: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ from_page: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid to_page' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ to_page: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ to_page: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ to_page: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ to_page: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid parallel_requests' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ parallel_requests: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ parallel_requests: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ parallel_requests: MAX_NUMBER_OF_PARALLEL_REQUESTS + 1 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ parallel_requests: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ parallel_requests: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with invalid sleep_between_retries_ms' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ sleep_between_retries_ms: 0 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ sleep_between_retries_ms: 1.5 }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ sleep_between_retries_ms: 'ascdesc' }) }
          .to raise_error(ArgumentError)
        expect { blockfrost.get_block_latest_transactions({ sleep_between_retries_ms: :symbol }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with to_page, without from_page' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ to_page: 10 }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with from_page > to_page' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ from_page: 15, to_page: 10 }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with from > to' do
      it 'raises an ArgumentError' do
        expect { blockfrost.get_block_latest_transactions({ from: 15, to: 10 }) }
          .to raise_error(ArgumentError)
      end
    end

    context 'with valid params' do
      it 'not raises an ArgumentError' do
        stub_cardano_success_request('/blocks/latest/txs?count=80&page=6', '{"answer": true}', 'project_id')
        stub_cardano_success_request('/blocks/latest/txs?count=80&page=5', '{"answer": true}', 'project_id')
        stub_cardano_success_request('/blocks/latest/txs?count=80&page=4', '{"answer": true}', 'project_id')
        stub_cardano_success_request('/blocks/latest/txs?count=80&page=3', '{"answer": true}', 'project_id')

        params = { order: 'asc', count: 80, from_page: 3, to_page: 6,
                   parallel_requests: 5, sleep_between_retries_ms: 200 }
        expect { blockfrost.get_block_latest_transactions(params) }.not_to raise_error(ArgumentError)
      end
    end
  end
end
