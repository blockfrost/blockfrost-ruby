# frozen_string_literal: true

require_relative '../../blockfrostruby/request'
require_relative '../../blockfrostruby/params'

module CustomEndpoints
  extend Request
  extend Params

  def get_custom_url(custom_url, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/#{custom_url}", @project_id, params)
  end

  def get_help_info
    'See the documentation here - https://github.com/blockfrost/blockfrost-ruby'
  end

  # METHODS WITH GET ALL
end
