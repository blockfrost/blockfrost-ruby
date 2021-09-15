# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module IPFSEndpoints
  extend Request
  extend Params

  # Calls get request on (@url)/ipfs/pin/list
  #
  # @param params [Hash] - params passed by user.
  # @return [Hash] formatted result with status and body keys.
  def get_localstorage_pinned_objects_list(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/ipfs/pin/list", @project_id, params)
  end

  # Calls get request on (@url)/ipfs/pin/list/(ipfs_path)
  #
  # @param ipfs_path [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_localstorage_pinned_object(ipfs_path)
    Request.get_response("#{@url}/ipfs/pin/list/#{ipfs_path}", @project_id)
  end

  # Calls get request on (@url)/ipfs/gateway/(ipfs_path)
  #
  # @param ipfs_path [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def get_relay_to_ipfs_gateway(ipfs_path)
    Request.get_response("#{@url}/ipfs/gateway/#{ipfs_path}", @project_id)
  end

  # Calls post request on (@url)/ipfs/add
  #
  # @param filepath [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def add_a_file(filepath)
    Request.post_file("#{@url}/ipfs/add", @project_id, filepath)
  end

  # Calls post request on (@url)/ipfs/pin/add/(ipfs_path)
  #
  # @param ipfs_path [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def pin_an_object(ipfs_path)
    Request.post_request_raw("#{@url}/ipfs/pin/add/#{ipfs_path}", @project_id)
  end

  # Calls post request on (@url)/ipfs//pin/remove/(ipfs_path)
  #
  # @param ipfs_path [String] will be added to the url for get request.
  # @return [Hash] formatted result with status and body keys.
  def remove_pinned_object(ipfs_path)
    Request.post_request_raw("#{@url}/ipfs/pin/remove/#{ipfs_path}", @project_id)
  end
end
