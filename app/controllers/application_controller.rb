include ActionController::MimeResponds

class ApplicationController < ActionController::API
  def authenticate
    token = request.env["HTTP_AUTHORIZATION"]
    package = Api::AuthToken.decode(token)
    if !package.nil?
      user_id = package.first[1]
      @current_user = User.find_by_id(user_id)
    end
    unless current_user
      response = { Unauthorized: "Unauthorized access, please login again" }
      render json: response.to_json
    end
  end

  def current_user
   return @current_user if @current_user && @current_user.session
  end
end
