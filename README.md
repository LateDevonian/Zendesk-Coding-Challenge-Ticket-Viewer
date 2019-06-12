# The Zendesk Ticket Viewer Internship Coding Challenge 2019

Welcome to my ticket viewer for the Zendesk code challenge.
The viewer uses the Zendesk API and returns pages of 25 tickets, each ticket can be selected for further details.

Dependencies:
* Ruby version : 2.6.1p33 (2019-01-30 revision 66950)

Deployment:
* Clone the github repo:
https://github.com/LateDevonian/Zendesk-Coding-Challenge-Ticket-Viewer
* in config/yml enter the details which I will email for authentication
* Run bundle install
* Run 'bundle exec shotgun' to start the server
* Type in `localhost:9393/tickets` in your browser window to get to the ticket list

Testing:
* Run 'bundle exec rspec' from the terminal to run all tests.

Requirements coverage:

## Display the tickets in a list

This is the first web page I have attempted that was not following a tutorial, I am aware it's pretty basic.
I chose to display just the ticket number and subject, each ticket clickable.

**Options for future development:**
- Style the page
- Add sort ability on the various returned attributes
- Add search ability

## Pagination

I chose to get only the full 100 tickets that the API provides.
I added a pagination feature to paginate 25 pages at a time, which covers the requirement as written.
Currently when it hits 100 it returns no more tickets, which is not ideal.

**Options for future development:**
- Restrict ticket return to 25 using the `?page=#{page}&per_page=#{per_page}` option
- Add an option to retrieve the next tickets via the API through the `response["next page"]` and `response["count"]` Zendesk API
- Dynamically display this on the tickets page for the user to select forward and back

## Display individual ticket details

I chose a number of attributes that were common to the tickets that I thought a user would want to look at, and hard-coded the display.

**Options for future development:**
- Only display data that are not null/empty (or specify null/empty in the output)
- Style the page
- Add an option to get ticket comments

## Error handling

I created a hold-all error response that funnels the status and error messages into the display for both the ticket list and the individual ticket if the get request fails
It currently covers any response that it gets like this

**Options for future development:**
- Use the ruby and/or httparty exception/rescue handling for more graceful responses
- Add 'back to a landing page' functionality

## Testing

I chose to stub the API and only test my ticket controller code and not hit the ZD API  
I used RSpec for testing. There are some gems in the file and the spec_helper that should format the output nicely for running the tests.
(Testing is underrated! Just putting that out there)

**Options for future development:**
- Browser tests for styling and page rendering as expected

## Scalability and future dev

* I chose to develop this as a Sinatra App as it's a framework that is suitable
for a small web application like this. I have much more to learn about Sinatra.
* In this instance I did not use active record or the sqlite3 database but given any future development on an app like this may require data entry, I included it for scalability
- Add a homepage/landing page at the root get/
- Add post/update/delete functionality
- Add authentication/security
