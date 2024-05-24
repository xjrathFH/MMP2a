# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    redirect_to root_path unless current_user || request.path == root_path
  end

  rescue_from ActiveRecord::RecordNotFound, with: :error_not_found

  def error_not_found
    render 'errors/404', status: :not_found
  end
end
