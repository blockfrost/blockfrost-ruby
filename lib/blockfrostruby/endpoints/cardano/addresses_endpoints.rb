# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module AddressesEndpoints
  extend Request
  extend Params

  # Example: addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz

  def get_address(address)
    Request.get_response("#{@url}/addresses/#{address}", @project_id)
  end

  def get_address_details(address)
    Request.get_response("#{@url}/addresses/#{address}/total", @project_id)
  end

  def get_address_utxos(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/addresses/#{address}/utxos", @project_id, params)
  end

  def get_address_transactions(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/addresses/#{address}/transactions", @project_id, params)
  end
end
