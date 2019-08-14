require 'faker'
require 'byebug'
module YourTickets

  class Generator

    def generate_ticket(id)
        pri = ["high", "medium", "low", nil]
        stat = %w[open, closed, unassigned, review]

        {
          "id" => id,
          "subject" => Faker::TvShows::VentureBros.character,
          "description" => Faker::TvShows::TwinPeaks.quote,
          "type" => Faker::TvShows::StarTrek.specie,
          "priority" => pri.sample,
          "status" => stat.sample,
          "updated_at" => Time.now,
          "assignee_id" => rand(2000..2002)
        }
    end

    def set_ticket_array(number)
      id = 1
      tickets = []
      while id <= number
        tickets << generate_ticket(id)
        id +=1
      end
      return tickets
    end

  end
end
