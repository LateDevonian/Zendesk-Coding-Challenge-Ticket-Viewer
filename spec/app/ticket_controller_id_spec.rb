require_relative '../../app/controllers/ticket_controller'
require 'rspec'
require 'byebug'
require 'rack/test'
require 'httparty'

RSpec.describe TicketController do
  include Rack::Test::Methods

  #tests the get /ticket/:id route and error
  #handling without hitting zd api

  def app
    TicketController.new
  end

  def generate_ticket
    {
      "id" => 14,
      "subject" => "Picard will be a terrible show",
      "description" => "I will stick to rewatching next gen",
      "type" => "incident",
      "priority" => "high",
      "status" => "open",
      "updated_at" => Time.now,
      "assignee_id" => 345
    }

  end

  describe 'GET /ticket/:id' do
    #happy path of ticket index request
    context 'retrieval of tickets is successful' do
      let(:parsed_response) { {"ticket" =>  generate_ticket } }
      let(:raw_response_code) { 200 }
      let(:raw_response_success) { true }
      let(:id){ 14 }

      let(:zd_response) do
        instance_double(
          HTTParty::Response,
          code: raw_response_code,
          parsed_response: parsed_response,
          success?: raw_response_success
        )
      end

      before do
        allow(HTTParty).to receive(:get)
        .and_return(zd_response)

        get "/tickets/#{id}"
      end

      describe 'successfully returns the tickets' do

        it 'returns a response code of 200' do
          expect(last_response.status).to eq(200)
        end

        it 'returns a valid response' do
          expect(last_response.empty?).to eq(false)
        end

        it 'returns a successful response' do
          expect(last_response.successful?).to eq(true)
        end

        it 'does not trip the error handing' do
          expect(last_response.body).to_not include("Something went wrong!")
        end

        it 'includes the ticket description' do
          expect(last_response.body).to include("I will stick to rewatching next gen")
        end
      end
    end


    context 'error handling' do
      #unhappy path!
      let(:raw_response_code) { 404 }
      let(:raw_response_success) { false }
      let(:id){ 10 }
      let(:parsed_response) { {"error" => "myerror", "description" => "mydescription" } }

      let(:err_response) do
        instance_double(
          HTTParty::Response,
          parsed_response: parsed_response,
          code: raw_response_code,
          success?: raw_response_success
        )
      end

      before do
        allow(HTTParty).to receive(:get)
        .and_return(err_response)
        get "/tickets/#{id}"
      end

      describe 'it handles errors' do

        it 'creates and returns an error message' do
          expect(last_response.body).to include("Something went wrong! 404 - myerror: mydescription ")
        end

      end
    end
  end
end
