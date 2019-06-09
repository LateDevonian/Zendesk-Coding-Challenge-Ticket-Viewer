require 'sinatra/base'
require 'json'
require 'byebug'
require 'httparty'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
require_relative './application_controller'

class TicketController < ApplicationController

  get '/tickets' do
     @tickets = api_get_tickets
     erb :'/tickets/index'
   end

  get '/tickets/:id' do
     @ticket = get_ticket_detail(params["id"])
     erb :'tickets/show_each'
  end

  private

  def set_request(url)
    user = "xx"
    pass = "yy"

    request = HTTParty.get(url, basic_auth: {username: user,
    password: pass }, :headers =>{'Content-Type' => 'application/json'} )
  end


  def api_get_tickets
    url = "https://moylen.zendesk.com/api/v2/tickets.json"
    response = set_request(url)
    if response.success?
       res = response.parsed_response
       t = res["tickets"]
       tickets = t.paginate(:page => params[:page], :per_page => 25)
      else
        error_handling(response.code)
    end
  end

  def get_ticket_detail(id)

    url = "https://moylen.zendesk.com/api/v2/tickets/#{id}.json"
    response = set_request(url)

    if response.success?
       res = response.parsed_response
       t = res["ticket"]
       #handle errors gracefully
      else
        code = response.code
        error_handling(code)
    end
  end

  def error_handling(code)
    case code
    when 404
      message = "#{code}: Page not found."
    when 500...600
      message = "#{code}: Oops! "
    else
      message = "something is terribly wrong!"
    end
  end
end
