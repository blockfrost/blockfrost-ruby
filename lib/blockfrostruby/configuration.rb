# frozen_string_literal: true

module Configuration
  class << self
    def default_config
      {
        return_whole_object_in_request: false,
        parallel_requests: 5,
        use_desc_order_as_default: false,
        default_count_per_page: 100,
        format_time_to_human: false
      }
    end

    def define_config(config)
      result = default_config
      config.each do |key, value|
        # rescue if result[key.to_sym].nil?
        result[key.to_sym] = value unless result[key.to_sym].nil?
      end
      result
    end
  end
end

# module Config
#   class Configuration
#     attr_accessor :use_full_response_object, :name
#     # use asc/desc order

#     def initialize(use_full_response_object = false, name = 'test')
#       @use_full_response_object = use_full_response_object
#       @name = name
#     end

#     def [](value)
#       self.public_send(value)
#     end
#   end

#   class << self
#     def configure
#       @configuration = Configuration.new
#       yield @configuration if block_given?
#       @configuration
#     end

#     def config
#       @configuration || configure
#     end
#   end
# end
