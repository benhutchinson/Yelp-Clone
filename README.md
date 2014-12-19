Yelp
====

This week we have been replicating aspects of Yelp in order to become familiar with the Ruby on Rails MVC web application framework.  We have followed test-driven-development design principles using RSpec for unit tests & Capybara/Poltergeist for feature/acceptance tests.  We have been introduced to the Devise gem and used OmniAuth with Facebook to take advantage of third-party authentication services.  We are using a PostgreSQL database in order to be compatible with Heroku and UTF-8 character sets in order to create star-ratings using Unicode characters.  Image files can be uploaded by authenticated users and their storage and integration is aided through the Paperclip gem and Amazon Web Services.  Review endorsements are managed through AJAX and jQuery, allowing endorsement counts to update dynamically without requiring a whole page refresh.  Our code is [hosted on Heroku](https://benclaudiayelp.herokuapp.com/) with image uploads being stored on Amazon Web Services.  

###Core Technologies
- Rails
- Devise, OAuth
- RSpec, Capybara, Poltergeist
- AJAX
- jQuery
- Paperclip
- AWS