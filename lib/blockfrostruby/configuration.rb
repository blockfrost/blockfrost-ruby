# frozen_string_literal: true

module Configuration
  class << self
    # TO YML file
    def default_config
      {
        use_desc_order_as_default: false,
        default_count_per_page: 100,
        return_full_object_in_response: false
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
