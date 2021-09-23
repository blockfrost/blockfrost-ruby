# frozen_string_literal: true

# Example: 81791e9e2b5929574039c38020374c753a548ef84bd7eaef8c908bdf43617264616e6f4b6f6d626174533154323541303035

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module AssetsEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/assets.
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_assets(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/assets", @project_id, params)
  end

  # Calls get request on (@url)/assets/(asset).
  #
  # @param asset [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_specific_asset(asset)
    Request.get_response("#{@url}/assets/#{asset}", @project_id)
  end

  # Calls get request on (@url)/assets/(asset)/history.
  #
  # @param asset [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_asset_history(asset, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/assets/#{asset}/history", @project_id, params)
  end

  # Calls get request on (@url)/assets/(asset)/transactions.
  #
  # @param asset [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_asset_transactions(asset, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/assets/#{asset}/transactions", @project_id, params)
  end

  # Calls get request on (@url)/assets/(asset)/addresses.
  #
  # @param asset [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_asset_addresses(asset, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/assets/#{asset}/addresses", @project_id, params)
  end

  # Calls get request on (@url)/assets/policy/(policy_id).
  #
  # @param policy_id [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_assets_of_policy(policy_id, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/assets/policy/#{policy_id}", @project_id, params)
  end
end
