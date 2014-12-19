Yelp
====

This week we have been replicating aspects of Yelp in order to become familiar with the Ruby on Rails MVC web application framework.  We have followed test-driven-development design principles using RSpec for unit tests & Capybara/Poltergeist for feature/acceptance tests.  We have been introduced to the Devise gem and used OmniAuth with Facebook to take advantage of third-party authentication services.  We are using a PostgreSQL database in order to be compatible with Heroku and UTF-8 character sets in order to create star-ratings using Unicode characters.  Image files can be uploaded by authenticated users and their storage and integration is aided through the Paperclip gem and Amazon Web Services.  Review endorsements are managed through AJAX and jQuery, allowing endorsement counts to update dynamically without requiring a whole page refresh.  Our code is [hosted on Heroku](https://benclaudiayelp.herokuapp.com/) with image uploads being stored on Amazon Web Services.

###The Biggest Challenge
The biggest challenge on this project actually lay in configuring Paperclip with AWS and to a lesser extent, Heroku.  I put together a basic work-through to aid many of our cohort since many of us struggled with this issue.

####1/ Check-list
- Ensure you run db:migrate
- Ensure your ENV files/keys are correctly set-up
- This applies to both local and Heroku.
- This sounds obvious but you may make changes so please don't forget.

####2/ AWS Account
- You will set up a user along with the S3 bucket.  Check that that user you set up has permissions that are appropriate as otherwise, you won't see images and you might see permission errors.

####3/ AWS - Note The Region
- You may have selected a region for your AWS S3.  You can see this when you are in AWS Console and look at the bucket.  On the right-hand of the screen, there is a button called Properties.  You click that and might see Ireland (as was my case).  This is important since this affects the URL of your AWS bucket.  e.g. not s3.amazon.com but something like `s3-eu-west-1.amazonaws.com` or something like that.  More on this to follow.

####4/ PaperClip Configuration.
- 2 things need doing here.
- a. A `paperclip.rb` initializer is needed in the `config/initializers` folder 
- b. You need to ensure that you are using the right domain for AWS that you noted above in both the production and development files in your environments folder within config.  Code extracts below.

####5/ Debugging Tips
- If you use Chrome, you can check the URL of the image (or lack of..).  If you are seeing `img src="s3.amazon` or something similar, you are half-way there and should check the region/domain as above.  If you are NOT seeing amazon, it is likely that the initializer file is missing.  
- Revisit point one.  If in doubt, run rake db:migrate, push it, and try it again.

####6/ Other
- I have only a general understanding of everything here as this has been my first experience with Paperclip & AWS, but I will [share an article](http://stackoverflow.com/questions/7257745/rails-3-amazon-s3-paperclip-eu-problem) I read and also highlight that I didn't properly understand what Paperclip was doing until I read [Paperclip's documentation on Github](https://github.com/thoughtbot/paperclip).  

####7/ Code Extract For Environment/Production Config

```ruby
- Rails.application.configure do

  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
    :bucket => ENV['S3_BUCKET_NAME'],
    :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
    },
    :s3_host_name => 's3-eu-west-1.amazonaws.com'
  }

  ```

####8/ Code Extract For paperclip.rb initializer
``` ruby
Paperclip::Attachment.default_options[:s3_host_name] = 's3-eu-west-1.amazonaws.com'
``` 

###Core Technologies
- Rails
- Devise, OAuth
- RSpec, Capybara, Poltergeist
- AJAX
- jQuery
- Paperclip
- AWS