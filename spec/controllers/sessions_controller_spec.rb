require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let!(:user) { create(:user, username: 'testuser', password: 'password123') }

  describe 'POST /sessions' do
    context 'with valid credentials' do
      it 'renders new session object' do
        allow(User).to receive(:find_by).and_return(user)
        allow(user).to receive(:authenticate).and_return(true)

        post :create, params: { session: { username: 'testuser', password: 'password123' } }

        expect(response.body).to include_json(
          message: 'Login successful',
          session: {
            id: anything,
            token: anything,
            user_id: user.id,
            created_at: anything,
            updated_at: anything
          }
        )
      end
    end

    context 'with invalid credentials' do
      it 'renders error' do
        allow(User).to receive(:find_by).and_return(nil)

        post :create, params: { session: { username: 'testuser', password: 'wrongpassword' } }

        expect(response.body).to eq({ errors: ['Invalid username or password'] }.to_json)
      end
    end
  end
end
