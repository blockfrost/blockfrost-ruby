# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module MetricsEndpoints
  extend Request

  # Calls get request on (@url)/metrics.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_metrics
    Request.get_response("#{@url}/metrics", @project_id)
  end

  # Calls get request on (@url)/metrics.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_metrics_endpoints
    Request.get_response("#{@url}/metrics/endpoints", @project_id)
  end
end
