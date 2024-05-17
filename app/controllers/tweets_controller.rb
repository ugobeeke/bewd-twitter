class TweetsController < ApplicationController

    
    def create
        token = cookies[:twitter_session_token]
        session = Session.find_by(token: token)
    
        if session
          @tweet = session.user.tweets.new(tweet_params)
          if @tweet.save
            render json: { message: 'Tweet created successfully', tweet: @tweet }, status: :created
          else
            render json: { errors: @tweet.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { errors: ['Not authenticated'] }, status: :unauthorized
        end
    end
  
    def destroy
        token = cookies[:twitter_session_token]
        session = Session.find_by(token: token)
    
        if session
          tweet = session.user.tweets.find_by(id: params[:id])
          if tweet
            tweet.destroy
            render json: { success: true }, status: :ok
          else
            render json: { errors: ['Tweet not found'] }, status: :not_found
          end
        else
          render json: { success: false }, status: :unauthorized
        end
    end
  
    def index
        @tweets = Tweet.all.includes(:user).map do |tweet|
          tweet.as_json(only: [:id, :message], include: { user: { only: [:username] } })
        end
        render json: { tweets: @tweets }, status: :ok
    end 
    def index_by_user
        user = User.find_by(username: params[:username])
    
        if user
          tweets = user.tweets.select(:id, :message, :user_id)  # Select desired attributes
          render json: tweets, include: :user  # Include user information (optional)
        else
          render json: { error: "User not found" }, status: :not_found
        end
      end
    private
  
    def tweet_params
      params.require(:tweet).permit(:message)
    end
end
  