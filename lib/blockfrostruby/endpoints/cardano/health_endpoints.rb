# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module HealthEndpoints
  extend Request

  def get_root(params = {})
    Request.get_response("#{@url}/", @project_id, params)
  end

  def get_health(params = {})
    Request.get_response("#{@url}/health", @project_id, params)
  end

  def get_health_clock(params = {})
    Request.get_response("#{@url}/health/clock", @project_id, params)
  end
end
