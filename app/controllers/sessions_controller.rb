class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:session][:username])
    
    if user && user.authenticate(params[:session][:password])
      session = user.sessions.create(token: SecureRandom.hex)
      render json: {
        message: 'Login successful',
        session: {
          id: session.id,
          token: session.token,
          user_id: user.id,
          created_at: session.created_at,
          updated_at: session.updated_at
        }
      }, status: :ok
    else
      render json: { errors: ['Invalid username or password'] }, status: :unauthorized
    end
  end
end
