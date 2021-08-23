# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'
require_relative '../../../blockfrostruby/params'

module IPFSEndpoints
  extend Request
  extend Params

  def get_localstorage_pinned_objects_list(params = {})
    params = Params.define_params(params, @config)
    Request.get_response("#{@url}/ipfs/pin/list", @project_id, params)
  end

  def get_localstorage_pinned_object(ipfs_path)
    Request.get_response("#{@url}/ipfs/pin/list/#{ipfs_path}", @project_id)
  end

  def get_relay_to_ipfs_gateway(ipfs_path)
    Request.get_response("#{@url}/ipfs/gateway/#{ipfs_path}", @project_id)
  end

  def add_a_file(filepath)
    Request.post_file("#{@url}/ipfs/add", @project_id, filepath)
  end

  def pin_an_object(ipfs_path)
    Request.post_request_raw("#{@url}/ipfs/pin/add/#{ipfs_path}", @project_id)
  end

  def remove_pinned_object(ipfs_path)
    Request.post_request_raw("#{@url}/ipfs/pin/remove/#{ipfs_path}", @project_id)
  end

  # METHODS WITH GET ALL
end
