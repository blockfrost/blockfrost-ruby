# frozen_string_literal: true

# Example hash: f6780212de5df00d10d929d0ca33dc2ff60cc57f38bd2b3cb3b2dea36f0c20b6

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module TransactionsEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/txs/(hash).
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction(hash)
    Request.get_response("#{@url}/txs/#{hash}", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/utxos.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_utxos(hash)
    Request.get_response("#{@url}/txs/#{hash}/utxos", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/stakes.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_stakes(hash)
    Request.get_response("#{@url}/txs/#{hash}/stakes", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/delegations.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_delegations(hash)
    Request.get_response("#{@url}/txs/#{hash}/delegations", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/withdrawals.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_withdrawals(hash)
    Request.get_response("#{@url}/txs/#{hash}/withdrawals", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/mirs.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_mirs(hash)
    Request.get_response("#{@url}/txs/#{hash}/mirs", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/pool_updates.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_pool_updates(hash)
    Request.get_response("#{@url}/txs/#{hash}/pool_updates", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/pool_retires.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_pool_retires(hash)
    Request.get_response("#{@url}/txs/#{hash}/pool_retires", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/metadata.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_metadata(hash)
    Request.get_response("#{@url}/txs/#{hash}/metadata", @project_id)
  end

  # Calls get request on (@url)/txs/(hash)/metadata/cbor.
  #
  # @param hash [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_metadata_in_cbor(hash)
    Request.get_response("#{@url}/txs/#{hash}/metadata/cbor", @project_id)
  end

  # Calls post request on (@url)/txs/submit.
  #
  # @param transaction_data [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def submit_transaction(transaction_data)
    Request.post_request_cbor("#{@url}/tx/submit", @project_id, transaction_data)
  end
end
