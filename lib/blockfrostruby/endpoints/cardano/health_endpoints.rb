# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module HealthEndpoints
  extend Request

  # Calls get request on (@url)/.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_root
    Request.get_response("#{@url}/", @project_id)
  end

  # Calls get request on (@url)/health.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_health
    Request.get_response("#{@url}/health")
  end

  # Calls get request on (@url)/health/clock.
  #
  # @return [Hash] formatted result with status and body keys.
  def get_health_clock
    Request.get_response("#{@url}/health/clock", @project_id)
  end
end
