# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module MetricsEndpoints
  extend Request

  def get_metrics(params = {})
    Request.get_response("#{@url}/metrics", @project_id, params)
  end

  def get_metrics_endpoints(params = {})
    Request.get_response("#{@url}/metrics/endpoints", @project_id, params)
  end
end
