# frozen_string_literal: true

require_relative 'constants'

module Validator
  class << self
   # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity,  Metrics/PerceivedComplexity, Style/GuardClause
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
      param_name = 'count'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
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
      param_value = 'from'
      if param
        validate_is_numeric(param, param_name)
        validate_is_integer(param, param_name)
        validate_is_positive(param, param_name)
      end
    end

    def validate_to(param)
      param_value = 'to'
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
      if to_page && from_page.nil? # TODO: refactor
        raise ArgumentError,
              '"to_page" argument should be specified with "from_page"'
      end

      if from_page
        validate_from_page(from_page)
      end

      if from_page && to_page
        validate_to_page(to_page)
        
        unless from_page <= to_page # TODO: refactor
          raise ArgumentError,
                '"to_page" argument should be greater or equal than "from_page"'
        end
      end
    end

    def validate_both_from_and_to(from, to)
      validate_from(from)
      validate_to(to)
      if from && to
        unless from <= to
          raise ArgumentError,
                '"to" argument must be greater or equal than "from"'
        end
      end
    end

   
    def validate_params(params)
      validate_count(params[:count])
      validate_page(params[:page])
      validate_order(params[:order])
      validate_both_from_and_to(params[:from], params[:to])
      validate_both_from_page_and_to_page(params[:from_page], params[:to_page])

      # TODO: think about
      if (params[:from_page] || params[:to_page]) && params[:page] 
        raise ArgumentError,
                'Do not specify "page" with "to_page" or "from_page"'
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/GuardClause
  end
end
