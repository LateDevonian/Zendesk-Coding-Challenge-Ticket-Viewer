require 'sinatra/base'
require 'json'
require 'byebug'
require 'yaml'
require 'httparty'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
require_relative './application_controller'


  def set_request(id)

    config = YAML.safe_load(File.open(File.expand_path('../../../config/config.yml', __FILE__)))

    @base_url = "#{config['environment']}"
    @user = "#{config['user']}"
    @pass = "#{config['password']}"
    id = id

    if id == 'nil'
      url = "#{@base_url}/tickets.json"
      else
        url = "#{@base_url}/tickets/#{id}.json"
    end

    request = HTTParty.get(url, basic_auth: {username: @user,
    password: @pass }, :headers =>{'Content-Type' => 'application/json'} )

  end


  def api_get_tickets
    response = set_request('nil')
    if response.success?
       res = response.parsed_response
       t = res["tickets"]
       tickets = t.paginate(:page => params[:page], :per_page => 25)
      else
        error_handling(response.code)
    end
  end

  def get_ticket_detail(id)
    response = set_request(id)

    if response.success?
       res = response.parsed_response
       t = res["ticket"]
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
