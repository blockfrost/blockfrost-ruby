# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module MetadataEndpoints
  extend Request
  extend Params

  # Example: 1990

  def get_transactions_metadata_labels(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/metadata/txs/labels", @project_id, params)
  end

  def get_transaction_metadata_content_in_json(label, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/metadata/txs/labels/#{label}", @project_id, params)
  end

  def get_transaction_metadata_content_in_cbor(label, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/metadata/txs/labels/#{label}/cbor", @project_id, params)
  end
end
