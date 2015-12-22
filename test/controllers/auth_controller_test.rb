require 'test_helper'

class AuthControllerTest < ActionDispatch::IntegrationTest
  test 'login user' do
    create_user
    post '/api/v1/auth/login',
         email: 'ruth@adanma.com', password: 'password'
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'invalid email' do
    create_user
    post '/api/v1/auth/login',
         email: 'adanma.com', password: 'password'
    assert_equal 401, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'Wrong email or password'
  end

  test 'invalid password' do
    create_user
    post '/api/v1/auth/login',
         email: 'ruth@adanma.com', password: 'gtyhrd'
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'Wrong email or password'
  end

  test 'logout user' do
    @auth_token = login
    get '/api/v1/auth/logout', {},
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON, 'Authorization' => @auth_token
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
