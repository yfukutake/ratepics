class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to signin_url
    end
  end
  
  def counts(user)
    @count_pictures=user.pictures.count
    @count_evaluations = current_user.evaluations.count
  end
  
end
