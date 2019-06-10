require_relative '../../app/controllers/ticket_controller'
require 'rspec'
require 'byebug'
require 'rack/test'
require 'httparty'

RSpec.describe TicketController do
  include Rack::Test::Methods

  #tests the get /ticket route and error
  #handling without hitting zd api

  def app
    TicketController.new
  end

  def generate_ticket
    {
      "id" => 1,
      "subject" => "Picard will be a terrible show",
      "description" => "I will stick to rewatching next gen",
      "type" => "incident",
      "priority" => "high",
      "status" => "open",
      "updated_at" => Time.now,
      "assignee_id" => 345
    }
  end

  describe 'GET /tickets' do
    #happy path of ticket index request
    context 'retrieval of tickets is successful' do
      let(:zd_parsed_response) { {"tickets" => Array.new(26){generate_ticket} } }
      let(:raw_response_code) { 200 }
      let(:raw_response_success) { true }

      let(:zd_response) do
        instance_double(
          HTTParty::Response,
          code: raw_response_code,
          parsed_response: zd_parsed_response,
          success?: raw_response_success
        )
      end

      before do
        allow(HTTParty).to receive(:get)
        .and_return(zd_response)

        get "/tickets"
      end

      describe 'successfully returns the tickets' do

        it 'tests the test by checking out the stub is working' do
          expect(HTTParty).to have_received(:get)
        end

        it 'returns a response code of 200' do
          expect(last_response.status).to eq(200)
        end

        it 'returns a valid response' do
          expect(last_response.empty?).to eq(false)
        end

        it 'returns a successful response' do
          expect(last_response.successful?).to eq(true)
        end

        it 'creates the ticket list' do
          expect(last_response.body).to include("Picard will be a terrible show")
        end

        it 'does not trip the error handing' do
          expect(last_response.body).to_not include("Something went wrong!")
        end

        it 'sends 2 pages when more than 25 tickets' do
          expect(last_response.body).to include("tickets?page=2")
        end

        it 'only sends 2 pages when more than 25 tickets' do
          expect(last_response.body).to_not include("tickets?page=3")
        end
      end
    end


    context 'error handling' do
      #unhappy path!
      let(:zd_parsed_response) { "thingy error" }
      let(:raw_response_code) { 404 }
      let(:raw_response_success) { false }
      let(:response_error) {"Borg Attack!"}
      let(:response_description) {"Seperate the saucer section!"}

      let(:err_response) do
        instance_double(
          HTTParty::Response,
          code: raw_response_code,
          parsed_response: zd_parsed_response,
          success?: raw_response_success
        )
      end

      before do
        allow(HTTParty).to receive(:get)
        .and_return(err_response)

        get "/tickets"
      end

        it 'returns a 404 error code' do
          expect(last_response.status).to eq(404)
        end

        # it 'includes a parsed response error' do
        #   expect(parsed_response.error).to eq 1
        # end

        it 'returns an successful response' do
          expect(last_response.successful?).to eq(false)
        end

        it 'goes down the fail path and sends and error' do
          expect(last_response.body).to include("Something went wrong!")
        end

      end
    end
  end
