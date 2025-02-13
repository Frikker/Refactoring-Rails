require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_params) do
      {
        name: 'John',
        surname: 'Doe',
        patronymic: 'Smith',
        email: 'john@example.com',
        gender: 'male',
        nationality: 'American',
        country: 'USA',
        age: 30,
        interests: ['Sports', 'Music'],
        skills: ['Ruby', 'Rails']
      }
    end

    before do
      create(:interest, name: 'Sports')
      create(:interest, name: 'Music')
      create(:skill, name: 'Ruby')
      create(:skill, name: 'Rails')
    end

    it 'creates a new user with valid parameters' do
      post '/api/v1/users', params: valid_params
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json['user']['email']).to eq('john@example.com')
    end

    it 'returns an error for invalid params' do
      invalid_params = valid_params.merge(email: '')
      post '/api/v1/users', params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
      json = JSON.parse(response.body)
      expect(json['email']).to include("can't be blank")
    end
  end

  describe 'GET /api/v1/users/:id' do
    let(:user) { create(:user) }

    it 'returns the user' do
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(:success)
      json = JSON.parse(response.body)
      expect(json['email']).to eq(user.email)
    end
  end
end
