require 'httparty'
require 'uri'
require 'json'
require 'rest-client'
require 'will_paginate/array'
require 'zendesk_api'
require 'will_paginate/active_record'

class Ticket

  def api_client
    @api_client ||= ZendeskAPI::Client.new do |config|
      config.url = "https://moylen.zendesk.com/api/v2"
      config.password = "table1"
      config.username = "moylengreen@hotmail.com"
      # config.access_token = "ce47bb8600a2cddb9a7c37659d9a0b79224bc44319c7b4c870e664478a14730f"
    end
  end

  def create_index
    @tickets = api_client.tickets

    #to_a raised an error if api offline
    # @tickets = @tickets.paginate(page: params[:page], per_page: 25)
    # @tickets = Ticket.all
  end

  def get_single
    @ticket = get_tickets.tickets.find(id: params[:id])
    if @ticket.nil?
      flash[:error] = "dead ticket"
      redirect_to root_path
    end
  end
end
