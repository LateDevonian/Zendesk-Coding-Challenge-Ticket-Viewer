<%= @ticket.each do |key,value| %>
  <%= key %>
  <%= value.each do |k,v| %>
    <%= k %>  <%= v %>
<% end %>

?page=#{page}&per_page=#{25}

environment: 'https://moylen.zendesk.com/api/v2'
user: 'moylengreen@hotmail.com'
password: 'table1'

<% flash.each do |type, value| %>
  <div class="flash <%= type %>">
    <%= value %>
  </div>
<% end %>

def get_request(id = nil)
  config = YAML.safe_load(File.open(File.expand_path('../../../config/config.yml', __FILE__)))
  base_url = "#{config['environment']}"
  user = "#{config['user']}"
  pass = "#{config['password']}"

  if id == nil
    url = "#{base_url}/tickets.json"
  else
    url = "#{base_url}/tickets/#{id}.json"
  end

  HTTParty.get(url, basic_auth: {username: user,
  password: pass }, headers: {'Content-Type' => 'application/json'} )
end

def api_get_tickets
  raw_response = get_request
  response = raw_response.parsed_response

  if raw_response.success?
    tickets = response["tickets"]
    @tickets = tickets.paginate(:page => params[:page], :per_page => 25)
  else
    handle_error(raw_response, response)
  end
end

def get_ticket_detail(id)
  raw_response = get_request(id)
  response = raw_response.parsed_response

  if raw_response.success?
    @ticket = response["ticket"]
  else
    handle_error(raw_response, response)
  end
end


def handle_error(raw_response, response)
  status = raw_response.code
  error = response["error"]
  description = response["description"]

  @error = "Something went wrong! #{status} - #{error}: #{description} "
end
end



<!DOCTYPE html>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <title>Your Tickets</title>
  </head>
  <body>
   <%= yield %>
  </body>
</html>
<td><a href="/tickets/<%= ticket["id"] %>"><%= ticket["subject"]%></a></td>
new
require 'sinatra/base'
require 'json'
require 'byebug'
require 'yaml'
require 'httparty'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
require_relative './application_controller'

class TicketController < ApplicationController

  get '/tickets' do
    api_get_tickets
    erb :'/tickets/index'
   end

  get '/tickets/:id' do
    get_ticket_detail(params["id"])
    erb :'tickets/show_each'
  end

  def get_request(url)
    config = YAML.safe_load(File.open(File.expand_path('../../../config/config.yml', __FILE__)))
    base_url = "#{config['environment']}"
    user = "#{config['user']}"
    pass = "#{config['password']}"
    url1 = "#{base_url}/#{url}"

    HTTParty.get(url1, basic_auth: {username: user,
    password: pass }, headers: {'Content-Type' => 'application/json'} )
  end

  def api_get_tickets

    url = "tickets.json"
    raw_response = get_request(url)
    response = raw_response.parsed_response

    if raw_response.success?
      tickets = response["tickets"]
      @tickets = tickets.paginate(:page => params[:page], :per_page => 25)
    else
      handle_error(raw_response, response)
    end
  end

  def get_ticket_detail(id)
    url = "tickets/#{id}.json"
    raw_response = get_request(url)
    response = raw_response.parsed_response

    if raw_response.success?
      @ticket = response["ticket"]
    else
      handle_error(raw_response, response)
    end

  def handle_error(raw_response, response)
    status = raw_response.code
    error = response["error"]
    description = response["description"]

    @error = "Something went wrong! #{status} - #{error}: #{description} "
  end
end
