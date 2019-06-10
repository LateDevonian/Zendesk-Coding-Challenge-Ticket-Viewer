require 'rspec'
require 'byebug'
require 'rack/test'
require_relative '../../app/controllers/ticket_controller'

RSpec.describe TicketController do
  include Rack::Test::Methods

  def app
    TicketController.new
  end


  describe 'it returns a 200 response when zd is there' do
    let(:api_r) {TicketController.new}
    let(:result) =

    it 'returns a 200 code when api is hit' do
      request = api_r.api_get_tickets
      expect(response.code).to eq 200


    end

  end


  describe 'it raises errors when invalid urls supplied'  do


    it 'returns the header stuff' do
      expect(result).to eq 1
    end
  end


  describe 'it gets posts available and parses them' do
    let(:response) {apitick.get_request(url)}
  end

   # let(:ticketController) {TicketController.new}
 # let(:api) {TicketController.new}
    # it 'returns the first post' do
    #   expect(response["id"]).to eq 1
    # end

   #  it 'includes the expected values in the first post ' do
   #    keys = get_keys(response)
   #    expect(keys).to match_array(["id","body","title","userId"])
   #  end
   #
   #  it 'gets the response code' do
   #    expect(response.code).to eq 200
   #  end
   #
   #  it 'does not return an empty post' do
   #    expect(response).not_to be_empty
   #  end
   #
   #  it 'returns a successful request to api'
   #  it 'gracefully handles a failure for the api'
   #  it 'contains paginated ticket details up to 25'
   #  it 'returns the details information of a single ticket'
   #
   #
   # xit 'gets 25 posts' do
   #   expect(response.count).to eq 25
   # end
   #
   # xit 'gets the next 25' do
   #   # response = unrinood.get_request(url)
   # end
   #
   # it 'gets a list of all the post names and descriptions'


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
