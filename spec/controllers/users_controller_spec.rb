require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        post :create, params: { user: { username: 'test', email: 'test@test.com', password: 'secure_password' } }
        expect(response).to have_http_status(:created)
        expect(response.body).to eq(User.last.to_json)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity' do
        post :create, params: { user: { username: 'test' } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include('errors')
      end
    end
  end
end
