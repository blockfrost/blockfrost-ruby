# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module AccountsEndpoints
  extend Request
  extend Params

  # Example: stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc

  def get_account_specific_address(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}", @project_id, params)
  end

  def get_account_rewards(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/rewards", @project_id, params)
  end

  # ALL -- THINK HOW TO PASS IT THROUGH CONFIG
  def get_account_rewards_all(address, params = {})
    # params = Params.define_params(params, @config)
    # Request.get_all_pages("#{@url}/accounts/#{address}/rewards", @project_id, params)
  end

  def get_account_history(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/history", @project_id, params)
  end

  def get_account_delegations(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/delegations", @project_id, params)
  end

  def get_account_registrations(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/registations", @project_id, params)
  end

  def get_account_withdrawals(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/withdrawals", @project_id, params)
  end

  def get_account_mirs(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/mirs", @project_id, params)
  end

  def get_account_addresses(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/addresses", @project_id, params, @config)
  end

  def get_account_addresses_assets(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/addresses/assets", @project_id, params)
  end
end
