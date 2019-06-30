
  #   def initialize(params = {})
  #     @ticket = ticket
  #     @tickets = tickets
  #     @error = error
  #     @ticket_page = ticket_page
  #     @params = params
  #   end
  #
  #   def params
  #     @params
  #   end
  #
  #   def ticket
  #     @ticket
  #   end
  #
  #   def tickets
  #     @tickets
  #   end
  #
  #   def error
  #     @error
  #   end
  #
  #   def ticket_page
  #     @ticket_page
  #   end
  #
  #
  #
  #
  #   def api_get_tickets(page: 1, max_page: 2)
  #      # <%= will_paginate @tickets %>
  #     #set pagination
  #     url = "tickets.json?page=#{page}&per_page=#{max_page}"
  #     raw_response = get_request(url)
  #     response = raw_response.parsed_response
  #
  #     if raw_response.success?
  #       # total = response['total']
  #       # ticket_count = response['tickets.count']
  #       next_page = response['next_page']
  #       previous_page = response['previous_page']
  #       count = response['count']
  #
  #     #  "next_page"=>"https://moylen.zendesk.com/api/v2/tickets.json?page=2&per_page=5",
  #     # "previous_page"=>nil,
  #     # "count"=>202
  #
  #       #while total > ticket_count
  #       #   page += 1
  #       #   url << "tickets.json?page=#{page}&per_page=#{max_page}"
  #       # end
  #       # response = raw_response.parsed_response
  #       tickets = response['tickets']
  #       @tickets = tickets.paginate(:page => params[:page], :per_page => max_page)
  #     else
  #       handle_error(raw_response, response)
  #     end
  #   end
  #
  #   def get_ticket_detail(id)
  #     url = "tickets/#{id}.json"
  #     raw_response = get_request(url)
  #     response = raw_response.parsed_response
  #
  #     if raw_response.success?
  #       @ticket = response["ticket"]
  #       handle_error(raw_response, response)
  #     end
  #   end
  #
  #   def handle_error(raw_response, response)
  #     status = raw_response.code
  #     error = response["error"]
  #     description = response["description"]
  #
  #     @error = "Something went wrong! #{status} - #{error}: #{description} "
  #   end

  # from ticket TicketController  # set_pagination_headers :tickets, only: [:index]

    # def initialize(api_handler: Api_handler.new)
    # @api = api_handler
    # super()
    # end
    #
    # def index
    #   @tickets = Api_hander.new(params)
    #   # @ticket = Api_handler.new(params)
    #   # @error = Api_handler.new(params)
    # end

    #
    # def index
    #    @tickets =  Post.all.paginate(:page => params[:page], :per_page => 4)
    #    render :json => @tickts.to_json(:methods => [:image_url])
    #  end
  #
