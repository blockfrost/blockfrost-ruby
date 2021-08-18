# frozen_string_literal: true

require_relative '../../blockfrostruby/request'

module MetricsEndpoints
  extend Request

  def get_metrics
    Request.get_response("#{@url}/metrics", @project_id)
  end

  def get_metrics_endpoints
    Request.get_response("#{@url}/metrics/endpoints", @project_id)
  end
end
