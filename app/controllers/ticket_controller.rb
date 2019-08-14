require 'sinatra/base'
require 'json'
require 'byebug'
require 'yaml'
require 'httparty'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
require_relative './application_controller'
require_relative '../models/send_request'

module YourTickets
  class TicketController < ApplicationController
    DEFAULT_PER_PAGE = 25
    DEFAULT_PAGE = 1

    def initialize(api_handler: Api_handler.new)
      @api = api_handler
      super()
    end

    get '/tickets' do
      current_page = params[:page] || DEFAULT_PAGE
      api_get_tickets(page: current_page, per_page: params[:per_page] || DEFAULT_PER_PAGE)
      @next_page = current_page.to_i + 1
      @last_page = current_page.to_i - 1
      @current_page = current_page.to_i

      erb :'/tickets/index'
     end

    get '/tickets/:id' do
        get_ticket_detail(params["id"])
      erb :'tickets/show_each'
    end


    private

    # def get_submitter(ticket)
    #   @tickets.each do |ticket|
    #     submitter = ticket["submitter_id"]
    #     return @user_name = ticket_get_name(@submitter)
    #   end
    # end

    def ticket_get_name(sub_id)
      url = "users/#{sub_id}.json"
      raw_response = @api.get_request(url)
        if raw_response.success?
          response_parsed = raw_response.parsed_response
          user = response_parsed["user"]
          user["name"]
        else
          "Submitter name not available"
        end
    end

    def api_get_tickets(page: 1, per_page: 2)
      url = "tickets.json?page=#{page}&per_page=#{per_page}"
      raw_response = @api.get_request(url)
      response = raw_response.parsed_response

      if raw_response.success?
        @tickets = response['tickets']
        @count = response['count']
        @max_page = (@count/per_page.to_f).ceil

        # @tickets.each do |ticket|
        #   submitter_id = ticket["submitter_id"]
        #   ticket["submitter_name"] =  ticket_get_name(submitter_id)
        # end


        # @tickets

      else
        handle_error(raw_response, response)
      end
    end


    def get_ticket_detail(id)
      url = "tickets/#{id}.json"
      raw_response = @api.get_request(url)
      response = raw_response.parsed_response

      if raw_response.success?
        @ticket = response["ticket"]
        submitter_id = ticket["submitter_id"]
        ticket["submitter_name"] =  ticket_get_name(submitter_id)
        @ticket
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
end
