# frozen_string_literal: true

require_relative '../../blockfrostruby/request'

module HealthEndpoints
  extend Request

  def get_root
    Request.get_response("#{@url}/", @project_id)
  end

  def get_health
    Request.get_response("#{@url}/health", @project_id)
  end

  def get_health_clock
    Request.get_response("#{@url}/health/clock", @project_id)
  end
end
