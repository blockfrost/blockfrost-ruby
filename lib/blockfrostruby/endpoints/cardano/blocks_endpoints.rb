# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module BlocksEndpoints
  extend Request
  extend Params

  def get_block_latest
    Request.get_response("#{@url}/blocks/latest", @project_id)
  end

  def get_block_latest_transactions(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/latest/txs", @project_id, params)
  end

  # Example: e5c2f478555da2a22b5908fa83296ba19154c458506405ea4f01dc0bc55be0d6
  def get_block(hash_or_number)
    Request.get_response("#{@url}/blocks/#{hash_or_number}", @project_id)
  end

  # Example: 37898661
  def get_block_in_slot(slot_number)
    Request.get_response("#{@url}/blocks/slot/#{slot_number}", @project_id)
  end

  # Example: 30895909 Example: 219
  def get_block_in_slot_in_epoch(slot_number, epoch_number)
    Request.get_response("#{@url}/blocks/epoch/#{epoch_number}/slot/#{slot_number}", @project_id)
  end

  # Example: 5ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a
  def get_list_of_next_blocks(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    # Request.get_response("#{@url}/blocks/#{hash_or_number}/next", @project_id, params)
    Request.get_pages("#{@url}/blocks/#{hash_or_number}/next", @project_id, params)
  end

  def get_list_of_next_blocks_2(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_pages_multi("#{@url}/blocks/#{hash_or_number}/next", @project_id, params)
  end

  def get_list_of_previous_blocks(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/#{hash_or_number}/previous", @project_id, params)
  end

  def get_block_transactions(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/#{hash_or_number}/txs", @project_id, params)
  end
end
