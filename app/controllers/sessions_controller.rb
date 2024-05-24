# frozen_string_literal: true

# Sessions Controller
class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    Rails.logger.warn(
      "in SessinsController, got #{request.env['omniauth.auth']}"
    )
    user = User.find_or_create_with_omniauth(request.env['omniauth.auth'])

    if user
      session[:user_id] = user.id
      session[:access_token] = user.access_token
      redirect_to root_path, notice: 'Logged in'
    else
      redirect_to login_path, alert: 'Log in failed'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:access_token] = nil
    redirect_to root_path, notice: 'Logged out'
  end

  def failure
    render json: params.to_json
  end
end
