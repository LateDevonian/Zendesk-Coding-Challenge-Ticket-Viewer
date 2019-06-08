#The Zendesk Ticket Viewer Internship Coding Challenge 2019

Welcome to my ticket viewer for the Zendesk code challenge.
The viewer uses the Zendesk API and returns a page of 25 tickets.

Dependencies:

* Ruby version : 2.6.1p33 (2019-01-30 revision 66950)

Deployment

* Clone the github repo
* Run bundle install
* Run 'bundle exec shotgun' to start the server
* Type in Localhost:9393

Testing
* Run 'bundle exec rspec' to run all tests


Notes and considerations

* This has been developed on the slowest Linux machine in the entire universe.
* I chose to develop this as a Sinatra App as it's a framework that is suitable
for a small web application, in the mistaken belief that 'I knew Sinatra'.
