require 'rspec'
require 'byebug'
require 'rack/test'
require_relative '../../lib/api_fetch'

RSpec.describe TicketRequest do

    #use jsonplaceholder.typicode.com

  let(:apitick) {TicketRequest.new}

  def get_keys(response)
    response.map{ |k,v| k }
  end

  describe 'it gets posts available and parses them' do
    let(:response) {apitick.get_request(url)}

    it 'returns the first post' do
      expect(response["id"]).to eq 1
    end

    it 'includes the expected values in the first post ' do
      keys = get_keys(response)
      expect(keys).to match_array(["id","body","title","userId"])
    end

    it 'gets the response code' do
      expect(response.code).to eq 200
    end

    it 'does not return an empty post' do
      expect(response).not_to be_empty
    end


   xit 'gets 25 posts' do
     expect(response.count).to eq 25
   end

   xit 'gets the next 25' do
     # response = unrinood.get_request(url)
   end

   it 'gets a list of all the post names and descriptions'
 end

  describe 'it gets all the details of a single ticket' do

    let(:url) { "#{base_url}/comments?postId=1" }
    let(:response) {apitick.get_request(url) }

    it 'finds all data for a given ticket' do
      url = "#{base_url}/posts/1/comments"
      response = apitick.list_tickets(url)
      r1 = response[0]
      keys = get_keys(r1)
      expect(keys).to match_array(["postId","id","name","email","body"])
    end
  end


  describe 'it raises errors when invalid urls supplied'  do

    it 'returns an error when post does not exist' do
      url = "#{base_url}/tickets/582"
      expect{ apitick.get_request(url) }.to raise_error(TypeError)
    end

    it 'returns an error when an invalid post request made' do
       post_request = {"body"=>"nothing useful data"}
       response = apitick.create_request(post_url, post_request)
       expect{response}.to raise_error(TypeError)
     end
  end
end
