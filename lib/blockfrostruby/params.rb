# frozen_string_literal: true

require_relative 'configuration'

module Params
  include Configuration

  class << self
    def permitted(params)
      params.transform_keys(&:to_sym).slice(:order, :page, :count)
    end

    def add_params_to_url(url, defined_params)
      # to work with previous versions of ruby
      # https://stackoverflow.com/questions/800122/best-way-to-convert-strings-to-symbols-in-hash
      return url if defined_params.empty?

      request_params = defined_params.map { |k, v| "#{k}=#{v}" }.join('&')
      "#{url}?#{request_params}"
    end

    def define_params(params, config)
      permitted_params = permitted(params)
      result = permitted_params
      result[:order] = define_order(result[:order], config)
      result.delete(:order) if result[:order] == nil
      result[:count] = define_count(result[:count], config)
      result.delete(:count) if result[:count] == nil
      result
    end

    def define_order(order_param, object_config)
      default_config = {
        return_whole_object_in_request: false,
        parallel_requests: 5,
        use_desc_order_as_default: false,
        default_count_per_page: 100
      }
      order_in_default_config = default_config[:use_desc_order_as_default] == false ? 'asc' : 'desc'
      order_in_object_config = object_config[:use_desc_order_as_default] == false ? 'asc' : 'desc'
      result = order_in_object_config if order_param == nil
      result = order_param if order_param != nil
      result = nil if result == order_in_default_config
      result
    end

    # Checks:
    # 1. Pass ({}, {use_desc_order_as_default: false}), should return {}
    # 2. Pass ({}, {use_desc_order_as_default: true}), should return {order: desc}
    # 3. Pass ({ order: 'desc' }, {use_desc_order_as_default: true}), should return {order: desc}
    # 4. Pass ({ order: 'asc' }, {use_desc_order_as_default: true}, should return {}
    # 5. Pass ({ order: 'asc' }, {use_desc_order_as_default: false}), should return {}
    # 6. Pass ({ order: 'desc'}, {use_desc_order_as_default: false}, should return {order: desc})

    def define_count(count_param, object_config)
      default_config = {
        return_whole_object_in_request: false,
        parallel_requests: 5,
        use_desc_order_as_default: false,
        default_count_per_page: 100
      }
      count_in_default_config = default_config[:default_count_per_page]
      count_in_object_config = object_config[:default_count_per_page]
      result = count_in_object_config if count_param == nil
      result = count_param if count_param != nil
      result = nil if result == count_in_default_config
      result 
    end
    
    # Checks:
    # 1. Pass ({}, {default_count_per_page: 100}), should return {}
    # 2. Pass ({}, {default_count_per_page: 5}), should return {count: 5}
    # 3. Pass ({count: 5}, {default_count_per_page: 100}), should return {count: 5}
    # 4. Pass ({count: 5}, {default_count_per_page: 5}), should return {count: 5}
    # 5. Pass ({count: 100}, {default_count_per_page: 100}), should return {}
    # 6. Pass ({count: 5}, {default_count_per_page: 100}), should return {count: 5})
    
    # Checks: pass combined params
  end
end
