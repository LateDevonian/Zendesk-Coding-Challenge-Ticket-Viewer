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
     # :layout => :main
   end

   get '/tickets/:id' do
     @ticket = get_ticket_detail
     erb :'tickets/show_each'
     # :layout => :main
   end


   # url = "https://moylen.zendesk.com/api/v2/tickets.json"
   # auth =  username: "moylengreen@hotmail.com", password: "table1"
   # header = 'Content-Type' => 'application/json'

  def api_get_tickets
    response = HTTParty.get("https://moylen.zendesk.com/api/v2/tickets.json", basic_auth: {username: "moylengreen@hotmail.com",
    password: "table1" }, :headers =>{'Content-Type' => 'application/json'} )
    if response.success?
       res = response.parsed_response
       t = res["tickets"]
       tickets = t.paginate(:page => params[:page], :per_page => 25)
       #handle errors gracefully
      else
        case response.code
        when 404
          message = "#{response.code}: Page not found."
        when 500...600
          message = "#{response.code}: Oops! "
        end
    end
  end

  def get_ticket_detail
    @ticket
  end
end