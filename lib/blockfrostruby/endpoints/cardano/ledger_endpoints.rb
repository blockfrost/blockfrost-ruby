# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module LedgerEndpoints
  extend Request

  # Calls get request on (@url)/genesis.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_genesis
    Request.get_response("#{@url}/genesis", @project_id)
  end
end
