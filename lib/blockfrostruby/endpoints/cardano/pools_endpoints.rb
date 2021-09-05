# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module PoolsEndpoints
  extend Request
  extend Params

  # Example: pool1g3vqq9cj30cmp4e57y3jpqzuj2hl72twp5qdlh2v89ejk4vnazs

  def get_pools(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools", @project_id, params)
  end

  def get_list_of_retired_pools(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/retired", @project_id, params)
  end

  def get_list_of_retiring_pools(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/retiring", @project_id, params)
  end

  def get_pool(pool_id)
    Request.get_response("#{@url}/pools/#{pool_id}", @project_id)
  end

  def get_pool_history(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/history", @project_id, params)
  end

  def get_pool_metadata(pool_id)
    Request.get_response("#{@url}/pools/#{pool_id}/metadata", @project_id)
  end

  def get_pool_relays(pool_id)
    Request.get_response("#{@url}/pools/#{pool_id}/relays", @project_id)
  end

  def get_pool_delegators(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/delegators", @project_id, params)
  end

  def get_pool_blocks(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/blocks", @project_id, params)
  end

  def get_pool_updates(pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/pools/#{pool_id}/updates", @project_id, params)
  end
end
