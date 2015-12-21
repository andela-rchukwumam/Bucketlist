require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'creates users' do
    post '/api/v1/users',
         { full_name: 'Ruth', email: 'ruth@adanma.com', password: 'password',
            password_confirmation: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    user = JSON.parse(response.body)
    assert_equal user['user']['full_name'], 'Ruth'
  end

  test 'invalid email' do
    post '/api/v1/users',
         { full_name: 'Ruth', email: 'ada.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'User could not be created'
  end

  test 'users without email' do
    post '/api/v1/users',
         { full_name: 'Ruth', email: nil, password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'User could not be created'
  end

  test 'users without name' do
    post '/api/v1/users',
         { full_name: nil, email: 'ruth@a.com', password: 'password' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'User could not be created'
  end

  test 'users without password' do
    post '/api/v1/users',
         { full_name: 'Ruth', email: 'ruth@ada.com', password: nil }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'User could not be created'
  end

  test 'users with password less than six characters' do
    post '/api/v1/users',
         { full_name: 'Ruth', email: 'ruth@ada.com', password: 'ada' }.to_json,
         'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Status'], 'User could not be created'
  end
end
