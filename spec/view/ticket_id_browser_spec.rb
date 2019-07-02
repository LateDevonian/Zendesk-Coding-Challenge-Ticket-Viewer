require_relative '../../app/controllers/ticket_controller'
require_relative '../spec_helper'
require_relative '../data/ticket_generator'
require 'rspec'
require 'byebug'
require 'rack/test'
require 'httparty'


module YourTickets

  RSpec.describe TicketController do
    include Rack::Test::Methods
    def app
      TicketController.new
    end

    def set_ticket_no(number)
      tg = Generator.new
      tg.set_array(number)
    end

    context 'check pages render' do

      describe 'gets and loads the pages' do
        #this does not use capyara, just rspec
        it 'displays the home page' do
          get '/tickets/about'
          last_response.should be_ok
        end

        it 'displays the ticket viewer page' do
          get '/tickets/index'
          last_response.should be_ok
        end

        it 'displays the individual ticket page' do
          get 'tickets/show_each'
          (last_response).should be_ok
        end
      end
    end

    context 'renders page elements' do
      let(:zd_parsed_response) { {"tickets" => set_ticket_no(26) , "count" => count_tickets} }
      let(:raw_response_code) { 200 }
      let(:raw_response_success) { true }
      let(:count_tickets) {26}

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

      # let(:response) {set_ticket_no(26)}

      describe 'renders the ticket page' do

         it 'puts response' do
           expect(last_response.body).to include("Picard will be a terrible show")
         end

        it 'has the title bar'
        it 'displays the tickets'
      end
    end
  end
end
