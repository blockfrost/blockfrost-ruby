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

    def validate_value_in_array(param, param_name, array)
    end


    def validate_from_page
    end
    
    def validate_to_page
    end

    def validate_count(count)
      count_name = 'count'
      if count
        validate_is_numeric(count, count_name)
        validate_is_positive(count, count_name)
        validate_lower_or_equal_than(count, count_name, MAX_COUNT_PER_PAGE)
      end
    end

   
    def validate_params(params)
      # From_page, to_page start
      if params[:to_page] && params[:from_page].nil?
        raise ArgumentError,
              '"to_page" argument should be specified with "from_page"'
      end
      if params[:from_page] && params[:to_page]
        unless params[:from_page].is_a?(Numeric) && params[:to_page].is_a?(Numeric) # Split
          raise ArgumentError,
                'Argument is not a numeric' # Specify
        end
        unless (params[:from_page]).positive? && (params[:to_page]).positive?  # Split
          raise ArgumentError,
                'Argument should be greater than zero' # Specify
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

      validate_count(params[:count])
      
      # if params[:count]
      #   validate_is_numeric(params[:count], 'count')
      #   # unless params[:count].is_a?(Numeric)
      #   #   raise ArgumentError,
      #   #         '"count" argument is not numeric'
      #   # end
      #   unless params[:count].positive?
      #     raise ArgumentError,
      #           '"count" argument must be greater than zero'
      #   end
      #   unless params[:count] <= MAX_COUNT_PER_PAGE
      #     raise ArgumentError,
      #           "\"count\" argument must be lower or equal to #{MAX_COUNT_PER_PAGE}"
      #   end
      # end

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

      if (params[:from_page] || params[:to_page]) && params[:page] 
        raise ArgumentError,
                'Do not specify "page" with "to_page" or "from_page"'
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Style/GuardClause
  end
end
