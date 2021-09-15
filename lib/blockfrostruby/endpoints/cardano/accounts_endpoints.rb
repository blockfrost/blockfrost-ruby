# frozen_string_literal: true

# Example: stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module AccountsEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/accounts/(address).
  #
  # @param address [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_account_address(address)
    Request.get_response("#{@url}/accounts/#{address}", @project_id)
  end

  # Calls get request on (@url)/accounts/(address)/rewards.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_rewards(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/rewards", @project_id, params)
  end

  # Calls get request on (@url)/accounts/(address)/history.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_history(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/history", @project_id, params)
  end

  # Calls get request on (@url)/accounts/(address)/delegations.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_delegations(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/delegations", @project_id, params)
  end

  # Calls get request on (@url)/accounts/(address)/registrations.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_registrations(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/registations", @project_id, params)
  end

  # Calls get request on (@url)/accounts/(address)/withdrawals.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_withdrawals(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/withdrawals", @project_id, params)
  end

  # Calls get request on (@url)/accounts/(address)/mirs.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_mirs(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/mirs", @project_id, params)
  end

  # Calls get request on (@url)/accounts/(address)/addresses.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_addresses(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/addresses", @project_id, params, @config)
  end

  # Calls get request on (@url)/accounts/(address)/addresses/assets.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_account_addresses_assets(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/accounts/#{address}/addresses/assets", @project_id, params)
  end
end
