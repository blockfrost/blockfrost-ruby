# frozen_string_literal: true

module Configuration
  class << self
    # TO YML file
    def default_config
      {
        use_desc_order_as_default: false, # rename to asc
        default_count_per_page: 100,
        parallel_requests: 5
      }
    end

    def define_config(config)
      result = default_config
      config.each do |key, value|
        result[key.to_sym] = value unless result[key.to_sym].nil?
      end
      result
    end
  end
end
