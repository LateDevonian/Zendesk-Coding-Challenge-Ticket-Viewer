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

    let(:tg) {Generator.new}

    def set_ticket_no(ticketnum)
      @tickets = tg.set_ticket_array(ticketnum)
      @ticketnum = ticketnum
    end

    context 'renders page elements in index' do
      let(:zd_parsed_response) { {"tickets" => @tickets , "count" => count_tickets} }
      let(:raw_response_code) { 200 }
      let(:raw_response_success) { true }
      let(:count_tickets) {@ticketnum}

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

      describe 'pagination working' do


        describe 'a single page of tickets'
        it 'returns one page for a single page' do
          set_ticket_no(2)
          expect(last_response.body).to include("You are on page 1 of 1")
        end

        it 'returns one page for a single page' do
          ticketnum = 25
          expect(last_response.body).to include("You are on page 1 of 1")
        end

        it 'returns one page for a single page' do
        ticketnum = 1
        expect(last_response.body).to include("First page")
        end
      end



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
  end
end
