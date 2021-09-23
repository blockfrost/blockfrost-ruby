# frozen_string_literal: true

# Example: addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module AddressesEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/addresses/(address).
  #
  # @param address [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_specific_address(address)
    Request.get_response("#{@url}/addresses/#{address}", @project_id)
  end

  # Calls get request on (@url)/addresses/(address)/total.
  #
  # @param address [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_address_details(address)
    Request.get_response("#{@url}/addresses/#{address}/total", @project_id)
  end

  # Calls get request on (@url)/addresses/(address)/utxos.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_address_utxos(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/addresses/#{address}/utxos", @project_id, params)
  end

  # Calls get request on (@url)/addresses/(address)/transactions.
  #
  # @param address [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_address_transactions(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/addresses/#{address}/transactions", @project_id, params)
  end
end
