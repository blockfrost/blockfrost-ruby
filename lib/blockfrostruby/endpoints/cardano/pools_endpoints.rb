# frozen_string_literal: true

# Example pool_id: pool1g3vqq9cj30cmp4e57y3jpqzuj2hl72twp5qdlh2v89ejk4vnazs

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module PoolsEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/pools.
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_pools(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools", @project_id, params)
  end

  # Calls get request on (@url)/pools/retired.
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_list_of_retired_pools(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/retired", @project_id, params)
  end

  # Calls get request on (@url)/pools/retiring.
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_list_of_retiring_pools(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/retiring", @project_id, params)
  end

  # Calls get request on (@url)/pools/(pool_id).
  #
  # @param pool_id [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_pool(pool_id)
    Request.get_response("#{@url}/pools/#{pool_id}", @project_id)
  end

  # Calls get request on (@url)/pools/(pool_id)/history.
  #
  # @param pool_id [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_pool_history(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/history", @project_id, params)
  end

  # Calls get request on (@url)/pools/(pool_id)/metadata.
  #
  # @param pool_id [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_pool_metadata(pool_id)
    Request.get_response("#{@url}/pools/#{pool_id}/metadata", @project_id)
  end

  # Calls get request on (@url)/pools/(pool_id)/relays.
  #
  # @param pool_id [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_pool_relays(pool_id)
    Request.get_response("#{@url}/pools/#{pool_id}/relays", @project_id)
  end

  # Calls get request on (@url)/pools/(pool_id)/delegators.
  #
  # @param pool_id [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_pool_delegators(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/delegators", @project_id, params)
  end

  # Calls get request on (@url)/pools/(pool_id)/blocks.
  #
  # @param pool_id [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_pool_blocks(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/blocks", @project_id, params)
  end

  # Calls get request on (@url)/pools/(pool_id)/updates.
  #
  # @param pool_id [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_pool_updates(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/updates", @project_id, params)
  end
end
