require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:auth_headers) { create(:user).create_new_auth_token }
  let(:user_parameters) { attributes_for(:user) }

  describe 'POST /users' do
    context 'with valid parameters' do
      before do
        post '/users', params: { user: user_parameters },
                       headers: auth_headers
      end

      it 'creates an user' do
        expect(User.last).to have_attributes user_parameters.except(:password)
      end

      it 'returns status ok' do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'with invalid parameters' do
      before do
        post '/users', params: { user: { name: user_parameters[:name] } },
                       headers: auth_headers
      end

      it 'returns status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed/)
      end
    end
  end

  describe 'PUT /users/:id' do
    context 'with existent record' do
      let(:user) { create(:user) }

      before do
        put "/users/#{user.id}", params:
          { user: { name: user_parameters[:name] } },
          headers: auth_headers
      end

      it 'updates the record' do
        expect(User.find(user.id))
          .to have_attributes(name: user_parameters[:name])
      end

      it 'returns status no_content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with not existent record' do
      before do
        put '/users/1000', params:
          { user: { name: user_parameters[:name] } },
          headers: auth_headers
      end

      it 'returns status not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a record not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    context 'with existent record' do
      let(:user) { create(:user) }
      before { delete "/users/#{user.id}", headers: auth_headers }

      it 'deletes the record' do
        expect(User.exists?(user.id)).to be_falsey
      end

      it 'returns status no_content' do
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'with not existent record' do
      before { delete '/users/1000', headers: auth_headers }

      it 'returns status not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a record not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end
end
