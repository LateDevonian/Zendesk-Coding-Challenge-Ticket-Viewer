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

  def generate_user(id)
    {
      "user" => {
        "id" =>   3000,
        "name" => "Angus McAngus"
      }
    }
  end

  context 'renders individual ticket page' do

    def generate_ticket
      {
        "id" => 14,
        "subject" => "Picard will be a terrible show",
        "description" => "I will stick to rewatching next gen",
        "type" => set_type,
        "priority" => set_prior,
        "status" => "open",
        "updated_at" => Time.now,
        "assignee_id" => assignee_id,
        "submitter_name" => submitter_name
      }
    end

    let(:zd_parsed_response) { {"tickets" => generate_ticket } }
    let(:raw_response_code) { 200 }
    let(:raw_response_success) { true }
    let(:count_tickets) {1}

    let(:user_parsed_response) { generate_user(3000)}
    let(:user_response_code) { 200 }
    let(:user_response_success) { true }


    let(:zd_response) do
      instance_double(
        HTTParty::Response,
        code: raw_response_code,
        parsed_response: zd_parsed_response,
        success?: raw_response_success
      )
    end

    let(:user_response) do
      instance_double(
        HTTParty::Response,
        code: user_response_code,
        parsed_response: user_parsed_response,
        success?: user_response_success
      )
    end

    before do
      allow(HTTParty).to receive(:get)
      .and_return(zd_response, user_response)
      # .and(user_response)
      get "/tickets"
    end
  end
end
