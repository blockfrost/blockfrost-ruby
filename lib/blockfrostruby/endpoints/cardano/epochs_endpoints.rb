# frozen_string_literal: true

# Example epoch_number: 225
# Example pool_id: pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module EpochsEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/epochs/latest.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_latest_epoch
    Request.get_response("#{@url}/epochs/latest", @project_id)
  end

  # Calls get request on (@url)/epochs/latest/parameters.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_latest_epoch_parameters
    Request.get_response("#{@url}/epochs/latest/parameters", @project_id)
  end

  # Calls get request on (@url)/epochs/(epoch_number).
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_epoch(epoch_number)
    Request.get_response("#{@url}/epochs/#{epoch_number}", @project_id)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/next.
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_list_of_next_epochs(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/next", @project_id, params)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/previous.
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_list_of_previous_epochs(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/previous", @project_id, params)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/stakes.
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_epoch_stakes(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/stakes", @project_id, params)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/stakes/(pool_id).
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_epoch_stakes_by_pool(epoch_number, pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/stakes/#{pool_id}", @project_id, params)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/blocks.
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_epoch_blocks(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/blocks", @project_id, params)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/bloks/(pool_id).
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @param pool_id [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_epoch_blocks_by_pool(epoch_number, pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/blocks/#{pool_id}", @project_id, params)
  end

  # Calls get request on (@url)/epochs/(epoch_number)/parameters.
  #
  # @param epoch_number [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_epoch_parameters(epoch_number)
    Request.get_response("#{@url}/epochs/#{epoch_number}/parameters", @project_id)
  end
end
