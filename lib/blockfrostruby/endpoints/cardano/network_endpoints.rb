# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module NetworkEndpoints
  extend Request

  def get_network
    Request.get_response("#{@url}/network", @project_id)
  end
end
