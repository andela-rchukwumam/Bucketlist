class Api::V1::UsersController < ApplicationController
  respond_to :json, :xml
  # before_action :authenticate, except: [:create]

  def create
    @user = User.new(user_params) if user_params
    if @user.save
      token = Api::AuthToken.encode(user: @user.id)
      render json: @user, meta: { token: token }
    else
      response = { status: 'failure', body: 'User could not be created' }
      render json: response.to_json
    end
  end

  private

  def user_params
    params.permit(:full_name, :email, :password, :password_confirmation)
  end
end
