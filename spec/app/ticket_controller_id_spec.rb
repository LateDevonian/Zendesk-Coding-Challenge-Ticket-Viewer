require_relative '../../app/controllers/ticket_controller'
require 'rspec'
require 'byebug'
require 'rack/test'

RSpec.describe TicketController do
  include Rack::Test::Methods

  def app
    TicketController.new
  end

  describe 'it gets all the details of a single ticket' do
    #
  end


  # describe 'it raises errors when invalid urls supplied'  do

  #
  #   result = api_get_tickets(url, usrname, password)
  #
  #   it 'returns the header stuff' do
  #     expect(result).to eq 1
  #   end



    # it 'returns an error when post does not exist' do
    #
    #   expect{ apitick.get_request(url) }.to raise_error(TypeError)
    # end

    # it 'returns an error when an invalid post request made' do
    #    post_request = {"body"=>"nothing useful data"}
    #    response = apitick.create_request(post_url, post_request)
    #    expect{response}.to raise_error(TypeError)
    #  end

end
