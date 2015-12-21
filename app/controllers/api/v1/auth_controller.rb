class Api::V1::AuthController < ApplicationController
  before_action :authenticate, except: [:login]

  def login
    user = User.find_by_email(auth_params[:email]) if auth_params
    if user && user.authenticate(auth_params[:password])
      user.session = true
      user.save
      token = Api::AuthToken.encode(user: user.id)

      render json: user, meta: { token: token }
    else
      response = { Status: 'Wrong email or password' }
      render json: response.to_json, status: 401
    end
  end

  def logout
    user = current_user
    user.session = false
    user.save
    response = { Status: 'success', body: 'Logged out successfully' }
    render json: response.to_json, status: 200
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
