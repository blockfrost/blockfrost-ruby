# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module EpochsEndpoints
  extend Request
  extend Params

  # Example: 225

  def get_latest_epoch
    Request.get_response("#{@url}/epochs/latest", @project_id)
  end

  def get_latest_epoch_parameters
    Request.get_response("#{@url}/epochs/latest/parameters", @project_id)
  end

  def get_epoch(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}", @project_id, params)
  end

  def get_list_of_next_epochs(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/next", @project_id, params)
  end

  def get_list_of_previous_epochs(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/previous", @project_id, params)
  end

  def get_epoch_stakes(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/stakes", @project_id, params)
  end

  # Example: pool1pu5jlj4q9w9jlxeu370a3c9myx47md5j5m2str0naunn2q3lkdy
  def get_epoch_stakes_by_pool(epoch_number, pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/stakes/#{pool_id}", @project_id, params)
  end

  def get_epoch_blocks(epoch_number, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/blocks", @project_id, params)
  end

  def get_epoch_blocks_by_pool(epoch_number, pool_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/blocks/#{pool_id}", @project_id, params)
  end

  def get_epoch_parameters(epoch_number)
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/epochs/#{epoch_number}/parameters", @project_id)
  end

  # METHODS WITH GET ALL
end
