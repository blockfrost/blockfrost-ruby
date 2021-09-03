# frozen_string_literal: true

require_relative 'configuration'
require_relative 'constants'

module Params
  include Configuration

  class << self
    def define_params(params, config)
      result = extract_params(params)
      validate_params(result)
      result[:order] = define_order(result[:order], config)
      result[:count] = define_count(result[:count], config)
      result.compact
    end

    private

    def extract_params(params)
      params.transform_keys(&:to_sym).slice(:order, :page, :count, :from, :to, :from_page, :to_page)
    end

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity,  Metrics/PerceivedComplexity, Style/GuardClause
    def validate_params(params)
      # From_page, to_page start
      if params[:to_page] && params[:from_page].nil?
        raise ArgumentError,
              '"from_page" argument should be specified with "to_page"'
      end
      if params[:from_page] && params[:to_page]
        unless params[:from_page].is_a?(Numeric) && params[:to_page].is_a?(Numeric) # Split
          raise ArgumentError,
                'Argument is not a numeric' # Specify
        end
        unless (params[:from_page]).positive? && (params[:to_page]).positive?  # Split
          raise ArgumentError,
                'Argument must be greater than zero' # Specify
        end
        unless params[:from_page] <= params[:to_page]
          raise ArgumentError,
                '"to_page" argument should be greater or equal than "from_page"'
        end
      end
      # From_page, to_page end

      if params[:order]
        unless params[:order].is_a?(String)
          raise ArgumentError,
                '"order" argument is not a string'
        end 
        unless %w[asc desc].include?(params[:order].downcase.strip)
          raise ArgumentError,
                '"order" argument should be "asc" or "desc"'
        end
      end

      if params[:count]
        unless params[:count].is_a?(Numeric)
          raise ArgumentError,
                '"count" argument is not numeric'
        end
        unless params[:count].positive?
          raise ArgumentError,
                '"count" argument must be greater than zero'
        end
        unless params[:count] <= MAX_COUNT_PER_PAGE
          raise ArgumentError,
                "\"count\" argument must be lower or equal to #{MAX_COUNT_PER_PAGE}"
        end
      end

      if params[:page]
        unless params[:page].is_a?(Numeric)
          raise ArgumentError,
                '"page" argument is not numeric'
        end
        unless params[:page].positive?
          raise ArgumentError,
                '"page" argument must be greater than zero'
        end
      end
      


      if params[:from]
        unless params[:from].is_a?(Numeric)
          raise ArgumentError,
                '"from" argument is not numeric'
        end
        unless params[:from].positive?
          raise ArgumentError,
                '"from" argument must be greater than zero'
        end
      end

      if params[:to]
        unless params[:to].is_a?(Numeric)
          raise ArgumentError,
                '"to" argument is not numeric'
        end
        unless params[:to].positive?
          raise ArgumentError,
                '"to" argument must be greater than zero'
        end
      end

      if params[:from] && params[:to]
        unless params[:from] <= params[:to]
          raise ArgumentError,
                '"to" argument must be greater or equal than "from"'
        end
      end
      
      # if params[:page]
      # if params[:from]
      # if params[:to]
      # params from page to page and from to

    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/GuardClause

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

    # PREDICT ERRORS WITH USING IT WITH FROM TO
    # AVOID USER TO USE FROM_PAGE WITH PAGE=
  end
end
