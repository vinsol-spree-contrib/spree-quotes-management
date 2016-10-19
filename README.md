#Spree Quotes Management

Provides user's quotes management for spree.

##Features

  * Registered Users can create quote from home page.
  * Admin can create, update, publish, un-publish, and delete quotes.
  * A carousel on home page to show selected quotes.

##Installation

###Add spree_quotes_management to your Gemfile:

  ```ruby
  gem 'spree_quotes_management', github: 'vinsol-spree-contrib/spree-quotes-management', branch: '3-0-stable'
  ```

###Bundle your dependencies and run the installation generator:

  ```shell
    bundle
    bundle exec rails g spree_quotes_management:install
  ```

##Working

### New Quotes by client:

  1. Logged in user can submit quote from home page, in 'How was your experience with us?' form.
  2. User can leave the 'Quoted By' field to submit quote as anonymous user.

### Admin Management Interface:
  1. Admin can view all quotes in Admin Panel -> Quotes tab.
  2. Admin can publish/un-publish quotes from there.
  3. Admin can edit any quote by clicking on Edit button.

##Testing

  Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

  ```shell
    bundle
    bundle exec rake test_app
    bundle exec rspec spec
  ```

## Contributing

  1. [Fork](https://help.github.com/articles/fork-a-repo) the project
  2. Make one or more well commented and clean commits to the repository. You can make a new branch here if you are modifying more than one part or feature.
  3. Add tests for it. This is important so I don’t break it in a future version unintentionally.
  4. Perform a [pull request](https://help.github.com/articles/using-pull-requests) in github's web interface.

## License
  Copyright (c) 2016 Vinsol, released under the New BSD License
