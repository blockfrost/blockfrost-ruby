# frozen_string_literal: true

 # Example label: 1990

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module MetadataEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/metadata/txs/labels.
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_transactions_metadata_labels(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/metadata/txs/labels", @project_id, params)
  end

  # Calls get request on (@url)/metadata/txs/labels/(label).
  #
  # @param label [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_metadata_content_in_json(label, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/metadata/txs/labels/#{label}", @project_id, params)
  end

  # Calls get request on (@url)/metadata/txs/labels/(label)/cbor.
  #
  # @param label [String] will be added to the url for get request.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_transaction_metadata_content_in_cbor(label, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/metadata/txs/labels/#{label}/cbor", @project_id, params)
  end
end
