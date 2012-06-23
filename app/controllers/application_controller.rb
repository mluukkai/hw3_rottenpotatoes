class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :has_rated
  helper_method :is_admin

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    return nil if not @current_user

    @current_user.name == "Matti Luukkainen"
  end

  def has_rated movie
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    movie.users.include?@current_user
  end
end
