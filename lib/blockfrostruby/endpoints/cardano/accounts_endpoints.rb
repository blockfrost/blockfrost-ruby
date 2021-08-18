# frozen_string_literal: true

require_relative '../../../blockfrostruby/request'

module AccountsEndpoints
  extend Request

  def get_account_address(address)
    # Example: stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc
    Request.get_response("#{@url}/accounts/#{address}", @project_id)
  end

  def get_account_rewards_history(address, params={})
    # Example: stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc
    Request.get_response("#{@url}/accounts/#{address}/rewards", @project_id, params)
  end

  def get_account_rewards_history_all(address, _order)
    # Example: stake1u9ylzsgxaa6xctf4juup682ar3juj85n8tx3hthnljg47zctvm3rc
    # Request.get_all_pages("#{@url}/accounts/#{address}/rewards", @project_id)
  end
end
