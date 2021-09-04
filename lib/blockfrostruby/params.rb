# frozen_string_literal: true

require_relative 'configuration'
require_relative 'validator'

module Params
  include Configuration
  include Validator

  class << self
    def define_params(params, config)
      result = extract_params(params)
      Validator.validate_params(result)
      result[:order] = define_order(result[:order], config)
      result[:count] = define_count(result[:count], config)
      result.compact
    end

    private

    def extract_params(params)
      params.transform_keys(&:to_sym).slice(:order, :page, :count, :from, :to, :from_page, :to_page)
    end

    def define_order(order_param, object_config)
      default_config = Configuration.default_config
      order_in_default_config = default_config[:use_asc_order_as_default] == true ? 'asc' : 'desc'
      order_in_object_config = object_config[:use_asc_order_as_default] == true ? 'asc' : 'desc'
      define_value(order_in_default_config, order_in_object_config, order_param)
    end

    # Checks:
    # 1. Pass ({}, {use_desc_order_as_default: false}), should return {}
    # 2. Pass ({}, {use_desc_order_as_default: true}), should return {order: desc}
    # 3. Pass ({ order: 'desc' }, {use_desc_order_as_default: true}), should return {order: desc}
    # 4. Pass ({ order: 'asc' }, {use_desc_order_as_default: true}, should return {}
    # 5. Pass ({ order: 'asc' }, {use_desc_order_as_default: false}), should return {}
    # 6. Pass ({ order: 'desc'}, {use_desc_order_as_default: false}, should return {order: desc})

    def define_count(count_param, object_config)
      default_config = Configuration.default_config
      count_in_default_config = default_config[:default_count_per_page]
      count_in_object_config = object_config[:default_count_per_page]
      define_value(count_in_default_config, count_in_object_config, count_param)
    end

    # Checks:
    # 1. Pass ({}, {default_count_per_page: 100}), should return {}
    # 2. Pass ({}, {default_count_per_page: 5}), should return {count: 5}
    # 3. Pass ({count: 5}, {default_count_per_page: 100}), should return {count: 5}
    # 4. Pass ({count: 5}, {default_count_per_page: 5}), should return {count: 5}
    # 5. Pass ({count: 100}, {default_count_per_page: 100}), should return {}
    # 6. Pass ({count: 5}, {default_count_per_page: 100}), should return {count: 5})

    # Checks: pass combined params

    def define_value(default_config_value, object_config_value, params_value)
      result = params_value.nil? ? object_config_value : params_value
      result = nil if result == default_config_value
      result
    end
  end
end
