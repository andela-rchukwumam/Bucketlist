include ActionController::MimeResponds
class ApplicationController < ActionController::API
  def current_user
    @current_user = User.find_by_id[session[:id]] if session[:id]
  end
end
