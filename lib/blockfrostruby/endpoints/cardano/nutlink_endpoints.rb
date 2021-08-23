# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module NutlinkEndpoints
  extend Request
  extend Params

  # Example: addr1qxqs59lphg8g6qndelq8xwqn60ag3aeyfcp33c2kdp46a09re5df3pzwwmyq946axfcejy5n4x0y99wqpgtp2gd0k09qsgy6pz

  def get_address_metadata_list(address)
    Request.get_response("#{@url}/nutlink/#{address}", @project_id)
  end

  def get_address_metadata_tickers_list(address, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/nutlink/#{address}/tickers", @project_id, params)
  end

  def get_ticker_records_by_address(address, ticker, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/nutlink/#{address}/tickers/#{ticker}", @project_id, params)
  end

  def get_ticker_records(ticker, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/nutlink/tickers/#{ticker}", @project_id, params)
  end

  # METHODS WITH GET ALL
end
