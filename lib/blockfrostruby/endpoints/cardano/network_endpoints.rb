# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module NetworkEndpoints
  extend Request

  # Calls get request on (@url)/network.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_network
    Request.get_response("#{@url}/network", @project_id)
  end
end
