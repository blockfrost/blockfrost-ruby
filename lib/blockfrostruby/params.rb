# frozen_string_literal: true

require_relative 'configuration'
require_relative 'validator'

module Params
  include Configuration
  include Validator

  class << self
    # Calling from endpoints to define params which should be passed to Request class.
    # It exctracts only permitted params, validates them, compares with params defined in config.
    # If param = default API param (ex. count = 100 ) and it shouldn't be added to the url, the method cut this param.
    # Also if there is no parallel_requests passing, it adds the parallel_requests value from object config.
    #   
    # @param params [Hash] includes passed hash to constructor.
    # @return [Hash] hash with valid params.
    def define_params(params, config)
      result = extract_params(params)
      Validator.validate_params(result)
      result[:order] = define_order(result[:order], config)
      result[:count] = define_count(result[:count], config)
      result[:parallel_requests] = define_parallel_requests(result[:parallel_requests], config)
      result[:sleep_between_retries_ms] = define_sleep_between_retries(result[:sleep_between_retries_ms], config)
      result.compact
    end

    private

    def extract_params(params)
      params.transform_keys(&:to_sym).slice(:order, :page, :count, :from, :to, :from_page, :to_page,
                                            :parallel_requests, :sleep_between_retries_ms)
    end

    def define_order(order_param, object_config)
      default_config = Configuration.default_config
      order_in_default_config = default_config[:use_asc_order_as_default] == true ? 'asc' : 'desc'
      order_in_object_config = object_config[:use_asc_order_as_default] == true ? 'asc' : 'desc'
      define_value(order_in_default_config, order_in_object_config, order_param)
    end

    def define_count(count_param, object_config)
      default_config = Configuration.default_config
      count_in_default_config = default_config[:default_count_per_page]
      count_in_object_config = object_config[:default_count_per_page]
      define_value(count_in_default_config, count_in_object_config, count_param)
    end

    def define_value(default_config_value, object_config_value, params_value)
      result = params_value || object_config_value
      # Need to do this to avoid adding ?param=value to request if it is default as in the API
      result = nil if result == default_config_value
      result
    end

    def define_parallel_requests(params_value, object_config)
      object_config_value = object_config[:parallel_requests]
      params_value.nil? ? object_config_value : params_value
    end

    def define_sleep_between_retries(params_value, object_config)
      object_config_value = object_config[:sleep_between_retries_ms]
      params_value.nil? ? object_config_value : params_value
    end
  end
end
