class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:session][:username])
  
      if user&.authenticate(params[:session][:password])
        # Successful authentication
        session[:user_id] = user.id
        render json: { authenticated: true, username: user.username }
      else
        # Authentication failure
        render json: { errors: ["Not authenticated"] }, status: :unauthorized
      end
    end
  
    def authenticated
      if current_user
        render json: { authenticated: true, username: current_user.username }
      else
        render json: { errors: ["Not authenticated"] }, status: :unauthorized
      end
    end
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
  