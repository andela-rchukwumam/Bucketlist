require 'test_helper'

class ListsControllerTest < ActionDispatch::IntegrationTest
  test 'creates a bucketlist' do
    auth_token = login
    post '/api/v1/lists/',
         { name: 'list 1' }.to_json,
         'Accept' => Mime::JSON,
         'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist['list']['name'], 'list 1'
  end

  test 'bucketlists without name' do
    auth_token = login
    post '/api/v1/lists/',
         { name: nil, publicity: true }.to_json,
         'Accept' => Mime::JSON,
         'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    error = JSON.parse(response.body)
    assert_equal error['name'][0], "can't be blank"
  end

  test 'shows users bucketlists and others public bucketlists' do
    auth_token = login
    get '/api/v1/lists', {},
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
  end

  test 'shows error message if bucketlist id is not found' do
    auth_token = login
    create_bucketlist
    get '/api/v1/lists/100', {},
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 400, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist['Error'], 'List not found'
  end

  test 'searches users bucketlists and others public bucketlists by name' do
    auth_token = login
    create_bucketlist
    get '/api/v1/lists', { q: 'My first list' },
        'Accept' => Mime::JSON,
        'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist['lists'][0]['name'], 'My first list'
  end

  test 'updates bucketlist' do
    auth_token = login
    list = create_bucketlist
    patch "/api/v1/lists/#{list.id}", { name: 'My updated bucketlist' }.to_json,
          'Accept' => Mime::JSON,
          'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 202, response.status
    assert_equal Mime::JSON, response.content_type
    bucketlist = JSON.parse(response.body)
    assert_equal bucketlist['list']['name'], 'My updated bucketlist'
  end

  test 'deletes bucketlist' do
    auth_token = login
    list = create_bucketlist
    delete "/api/v1/lists/#{list.id}", {},
           'Accept' => Mime::JSON,
           'Content-Type' => Mime::JSON.to_s, 'Authorization' => auth_token
    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type
    status = JSON.parse(response.body)
    assert_equal status['Deleted'], 'Bucketlist has been deleted'
  end
end
