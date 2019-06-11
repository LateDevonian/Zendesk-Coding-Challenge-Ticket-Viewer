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
  end

  def handle_error(raw_response, response)
    status = raw_response.code
    error = response["error"]
    description = response["description"]

    @error = "Something went wrong! #{status} - #{error}: #{description} "
  end
end
