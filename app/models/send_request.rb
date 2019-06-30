require 'byebug'
require 'will_paginate/array'
require 'will_paginate/view_helpers/sinatra'
module YourTickets

  class Api_handler


    def get_request(url)

      config = YAML.safe_load(File.open(File.expand_path('../../../config/config.yml', __FILE__)))
      base_url = "#{config['environment']}"
      user = "#{config['user']}"
      pass = "#{config['password']}"
      url1 = "#{base_url}/#{url}"

       HTTParty.get(url1, basic_auth: {username: user,
       password: pass }, headers: {'Content-Type' => 'application/json'} )
     end

     def post_request(url, body)
       # request_address = set_config(url)
       #do soemthing with body
       # HTTParty.post(request_address)
     end

     def delete_request(url)
     end

     def update_request(url,body)
     end

   end
end
