# frozen_string_literal: true

require_relative 'constants'

# rubocop:disable Style/GuardClause
module Validator
  class << self
    # rubocop:disable Metrics/AbcSize
    def validate_params(params)
      validate_count(params[:count])
      validate_page(params[:page])
      validate_order(params[:order])
      validate_both_from_and_to(params[:from], params[:to])
      validate_both_from_page_and_to_page(params[:from_page], params[:to_page])
      validate_parallel_requests(params[:parallel_requests])
      validate_sleep_between_retries(params[:sleep_between_retries_ms])

      if (params[:from_page] || params[:to_page]) && params[:page]
        raise ArgumentError,
              'Do not specify "page" with "to_page" or "from_page"'
      end
    end
    # rubocop:enable Metrics/AbcSize

    def validate_init_params(config)
      validate_count(config[:default_count_per_page])
      validate_use_order(config[:use_asc_order_as_default])
      validate_parallel_requests(config[:parallel_requests])
      validate_sleep_between_retries(config[:sleep_between_retries_ms])
    end

    private

    def validate_use_order(param)
      param_name = 'use_asc_order_as_default'
      validate_is_boolean(param, param_name) if param
    end

    def validate_parallel_requests(param)
      param_name = 'parallel_requests'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
        validate_lower_or_equal_than(param, param_name, MAX_NUMBER_OF_PARALLEL_REQUESTS)
      end
    end

    def validate_sleep_between_retries(param)
      param_name = 'sleep_between_retries_ms'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
      end
    end

    def validate_count(param)
      param_name = 'count'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
        validate_lower_or_equal_than(param, param_name, MAX_COUNT_PER_PAGE)
      end
    end

    def validate_page(param)
      param_name = 'page'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
        validate_lower_or_equal_than(param, param_name, MAX_COUNT_PER_PAGE)
      end
    end

    def validate_order(param)
      param_name = 'order'
      valid_values = %w[asc desc]
      if param
        validate_is_string(param, param_name)
        validate_string_is_in_array(param, param_name, valid_values)
      end
    end

    def validate_from(param)
      param_name = 'from'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
      end
    end

    def validate_to(param)
      param_name = 'to'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
      end
    end

    def validate_from_page(param)
      param_name = 'from_page'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
      end
    end

    def validate_to_page(param)
      param_name = 'to_page'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
      end
    end

    def validate_both_from_page_and_to_page(from_page, to_page)
      if to_page && from_page.nil?
        raise ArgumentError,
              '"to_page" argument should be specified with "from_page"'
      end

      validate_from_page(from_page) if from_page

      if from_page && to_page
        validate_to_page(to_page)

        unless from_page <= to_page
          raise ArgumentError,
                '"to_page" argument should be greater or equal than "from_page"'
        end
      end
    end

    def validate_both_from_and_to(from, to)
      validate_from(from)
      validate_to(to)
      if from && to && from > to
        raise ArgumentError,
              '"to" argument must be greater or equal than "from"'
      end
    end

    def validate_is_numeric(param, param_name)
      unless param.is_a?(Numeric)
        raise ArgumentError,
              "\"#{param_name}\" is not a numeric"
      end
    end

    def validate_is_integer(param, param_name)
      unless param.is_a?(Integer)
        raise ArgumentError,
              "\"#{param_name}\" is not an integer"
      end
    end

    def validate_is_boolean(param, param_name)
      unless param.is_a?(TrueClass) || param.is_a?(FalseClass)
        raise ArgumentError,
              "\"#{param_name}\" is not a true or a false"
      end
    end

    def validate_is_string(param, param_name)
      unless param.is_a?(String)
        raise ArgumentError,
              "\"#{param_name}\" is not a string"
      end
    end

    def validate_is_positive(param, param_name)
      unless param.positive?
        raise ArgumentError,
              "\"#{param_name}\" should be greater than zero"
      end
    end

    def validate_greater_or_equal_than(param, param_name, value)
      unless param >= value
        raise ArgumentError,
              "\"#{param_name}\" should be greater or equal than #{value}"
      end
    end

    def validate_lower_or_equal_than(param, param_name, value)
      unless param <= value
        raise ArgumentError,
              "\"#{param_name}\" should be lower or equal than #{value}"
      end
    end

    def validate_string_is_in_array(param, param_name, array)
      unless array.include?(param.downcase.strip)
        raise ArgumentError,
              "\"#{param_name}\" should be one of: #{array}"
      end
    end
  end
end
# rubocop:enable Style/GuardClause
