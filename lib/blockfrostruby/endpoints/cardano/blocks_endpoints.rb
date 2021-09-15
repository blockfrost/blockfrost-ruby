# frozen_string_literal: true

# Example hash_or_number: 5ea1ba291e8eef538635a53e59fddba7810d1679631cc3aed7c8e6c4091a516a
# Example slot_number: 30895909
# Example epoch_number: 219

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module BlocksEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/blocks/latest.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_block_latest
    Request.get_response("#{@url}/blocks/latest", @project_id)
  end

  # Calls get request on (@url)/blocks/latest/txs.
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_block_latest_transactions(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/latest/txs", @project_id, params)
  end

  # Calls get request on (@url)/blocks/(hash_or_number).
  #
  # @param hash_or_number [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_block(hash_or_number)
    Request.get_response("#{@url}/blocks/#{hash_or_number}", @project_id)
  end

  # Calls get request on (@url)/blocks/slot/(slot_number).
  #
  # @param slot_number [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_block_in_slot(slot_number)
    Request.get_response("#{@url}/blocks/slot/#{slot_number}", @project_id)
  end

  # Calls get request on (@url)/blocks/epoch/(epoch_number)/slot/(slot_number).
  #
  # @param slot_number [String] will be added to the url for get request.
  # @param epoch_number [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_block_in_slot_in_epoch(slot_number, epoch_number)
    Request.get_response("#{@url}/blocks/epoch/#{epoch_number}/slot/#{slot_number}", @project_id)
  end

  # Calls get request on (@url)/blocks/(hash_or_number)/next.
  #
  # @param hash_or_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_list_of_next_blocks(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/#{hash_or_number}/next", @project_id, params)
  end

  # Calls get request on (@url)/blocks/(hash_or_number)/previous.
  #
  # @param hash_or_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_list_of_previous_blocks(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/#{hash_or_number}/previous", @project_id, params)
  end

  # Calls get request on (@url)/blocks/(hash_or_number)/txs.
  #
  # @param hash_or_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_block_transactions(hash_or_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/blocks/#{hash_or_number}/txs", @project_id, params)
  end
end
