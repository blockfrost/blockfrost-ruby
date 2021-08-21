# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module LedgerEndpoints
  extend Request

  def get_genesis
    Request.get_response("#{@url}/genesis", @project_id)
  end
end
