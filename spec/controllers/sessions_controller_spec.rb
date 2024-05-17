require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid credentials' do
      let(:user) { create(:user) }  # Create a user using FactoryBot

      it 'authenticates the user' do
        post :create, params: { session: { username: user.username, password: 'password' } }  # Replace 'password' with actual value
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({
          authenticated: true,
          username: user.username
        }.to_json)
      end
    end

    context 'with invalid credentials' do
      it 'returns authentication error' do
        post :create, params: { session: { username: 'invalid_user', password: 'wrong_password' } }
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('errors')
      end
    end
  end

  describe 'GET #authenticated' do
    context 'with authenticated user' do
      let(:user) { create(:user) }

      before { session[:user_id] = user.id }  # Simulate login before request

      it 'returns user information' do
        get :authenticated
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({
          authenticated: true,
          username: user.username
        }.to_json)
      end
    end

    context 'without authenticated user' do
      it 'returns authentication error' do
        get :authenticated
        expect(response).to have_http_status(:unauthorized)
        expect(response.body).to include('errors')
      end
    end
  end
end
