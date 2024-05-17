require 'rails_helper'

RSpec.describe TweetsController, type: :controller do
  describe 'GET #index_by_user' do
    context 'with valid username' do
      let(:user) { create(:user) }

      # Create some tweets associated with the user
      let!(:tweets) { create_list(:tweet, 2, user: user) } 

      it 'renders user tweets' do
        get :index_by_user, params: { username: user.username }
        # ... rest of your test logic (e.g., verify response structure)
      end
    end

    context 'with invalid username' do
      it 'returns user not found error' do
        get :index_by_user, params: { username: 'invalid_username' }
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('error')
      end
    end
  end
end
