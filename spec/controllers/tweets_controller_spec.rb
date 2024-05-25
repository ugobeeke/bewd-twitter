require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  let!(:user) { create(:user, username: 'user1', password: 'password123') }
  let!(:auth_token) { user.auth_token }

  before do
    request.headers['Authorization'] = auth_token
  end

  describe 'GET #index' do
    it 'renders all tweets' do
      get :index
      expect(response).to be_successful
      # Add assertions for the response
    end
  end

  describe 'GET #index_by_user' do
    it 'renders tweets by username' do
      get :index_by_user, params: { username: user.username }
      expect(response).to be_successful
      # Add assertions for the response
    end
  end

  describe 'POST #create' do
    it 'creates a new tweet' do
      post :create, params: { tweet: { message: 'Test message' } }
      expect(response).to be_successful
      # Add assertions for the response
    end
  end

  describe 'DELETE #destroy' do
    let!(:tweet) { create(:tweet, user: user) }

    it 'deletes the tweet if authenticated' do
      delete :destroy, params: { id: tweet.id }
      expect(response).to be_successful
      # Add assertions for the response
    end

    it 'fails to delete if not authenticated' do
      request.headers['Authorization'] = nil
      delete :destroy, params: { id: tweet.id }
      expect(response).to have_http_status(:unauthorized)
      # Add assertions for the response
    end
  end
end
