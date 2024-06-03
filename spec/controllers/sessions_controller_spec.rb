require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, username: 'testuser', password: 'password123') }

  describe 'POST /sessions' do
    context 'with valid credentials' do
      it 'renders new session object' do
        allow(User).to receive(:find_by).and_return(user)
        allow(user).to receive(:authenticate).and_return(true)

        post :create, params: { session: { username: 'testuser', password: 'password123' } }

        json_response = JSON.parse(response.body)

        expect(json_response['message']).to eq('Login successful')
        expect(json_response['session']['id']).to be_a(Integer)
        expect(json_response['session']['token']).to be_a(String)
        expect(json_response['session']['user_id']).to eq(user.id)
        expect(json_response['session']['created_at']).to be_a(String)
        expect(json_response['session']['updated_at']).to be_a(String)
      end
    end

    context 'with invalid credentials' do
      it 'renders error' do
        allow(User).to receive(:find_by).and_return(nil)

        post :create, params: { session: { username: 'testuser', password: 'wrongpassword' } }

        json_response = JSON.parse(response.body)

        expect(json_response['errors']).to include('Invalid username or password')
      end
    end
  end
end
