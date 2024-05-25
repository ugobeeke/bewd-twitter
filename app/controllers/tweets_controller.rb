class TweetsController < ApplicationController
  before_action :authenticate!

  def create
    tweet = current_user.tweets.new(tweet_params)
    if tweet.save
      render json: { message: 'Tweet created successfully', tweet: tweet }, status: :created
    else
      render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    tweet = current_user.tweets.find_by(id: params[:id])
    if tweet
      tweet.destroy
      render json: { success: true }, status: :ok
    else
      render json: { errors: ['Tweet not found'] }, status: :not_found
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
      tweets = user.tweets.select(:id, :message, :user_id)
      render json: tweets, include: { user: { only: [:username] } }
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def tweet_params
    params.require(:tweet).permit(:message)
  end

  def authenticate!
    render json: { errors: ['Not authenticated'] }, status: :unauthorized unless current_user
  end
end
