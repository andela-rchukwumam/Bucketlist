class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by_email(auth_params[:email]) if auth_params
    if user && user.authenticate(auth_params[:password])
      token = Api::AuthToken.encode(user: user.id)

      render json: user, meta: { token: token }
    else
      response = { status: 'failure', body: "Wrong email or password" }
      render json: response.to_json
    end
  end

  def logout
    response = { status: 'success', body: "Logged out successfully" }
    render json: response.to_json
  end

  private
 
  def auth_params
    params.permit(:email, :password)
  end
end