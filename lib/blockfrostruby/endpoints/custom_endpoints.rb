# frozen_string_literal: true

require_relative '../../blockfrostruby/request'
require_relative '../../blockfrostruby/params'

module CustomEndpoints
  extend Request
  extend Params

  # Add url from object and calls get request on specified url.
  #
  # @param custom_url [string] url to request. Url from object will be added before this param.
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_custom_url(custom_url, params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/#{custom_url}", @project_id, params)
  end

  # Return a string with a link to documentation.
  #
  # @return [String] link to documentation.
  def get_help_info
    'See the documentation here - https://github.com/blockfrost/blockfrost-ruby'
  end
end
