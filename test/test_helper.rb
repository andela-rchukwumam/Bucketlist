ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'coveralls'
Coveralls.wear!

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
    CodeClimate::TestReporter::Formatter,
    Coveralls::SimpleCov::Formatter
  ]
end

# class ActiveSupport::TestCase
#   # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
#   fixtures :all

#   # Add more helper methods to be used by all tests here...
# end

module ActionDispatch
  class IntegrationTest
    def create_user
      @user = User.create(full_name: 'Ruth', email: 'ruth@adanma.com',
                          password: 'password', password_confirmation: 'password')
    end

    def second_user
      @user = User.create(full_name: 'Ada', email: 'ada@ruth.com',
                          password: 'password', password_confirmation: 'password')
    end

    def login
      create_user
      post '/api/v1/auth/login',
           email: 'ruth@adanma.com', password: 'password'
      result = JSON.parse(response.body)
      result['meta']['token']
    end

    def second_login
      another_user
      post '/api/v1/auth/login',
           email: 'ada@ruth.com', password: 'password'
      result = JSON.parse(response.body)
      result['token']
    end

    def logout
      @auth_token = login
      get '/api/v1/auth/logout', {},
          'Accept' => Mime::JSON,
          'Content-Type' => Mime::JSON.to_s, 'Authorization' => @auth_token
    end

    def create_bucketlist
      @auth_token = login
      List.create(name: "My first list")
    end

    def create_item
      create_bucketlist
      8.times do
        post '/api/v1/lists/1/items',
             { name: 'My item', done: true }.to_json,
             'Accept' => Mime::JSON,
             'Content-Type' => Mime::JSON.to_s, 'Authorization' => @auth_token
      end
    end
  end
end