require 'rails_helper'

RSpec.describe 'OAuth Basic Tests', type: :routing do
  describe 'OAuth routes' do
    it 'has login route' do
      expect(get: '/login').to route_to(controller: 'pages', action: 'login')
    end

    it 'has welcome route' do
      expect(get: '/welcome').to route_to(controller: 'pages', action: 'welcome')
    end

    it 'has OAuth callback route' do
      expect(get: '/auth/google_oauth2/callback').to route_to(controller: 'sessions', action: 'create', provider: 'google_oauth2')
    end

    it 'has OAuth failure route' do
      expect(get: '/auth/failure').to route_to(controller: 'sessions', action: 'failure')
    end

    it 'has sign out route' do
      expect(delete: '/sign_out').to route_to(controller: 'sessions', action: 'destroy')
    end
  end

  describe 'User model' do
    it 'validates presence of email' do
      user = User.new(provider: 'google_oauth2', uid: '123')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it 'validates presence of provider' do
      user = User.new(email: 'test@example.com', uid: '123')
      expect(user).not_to be_valid
      expect(user.errors[:provider]).to include("can't be blank")
    end

    it 'validates presence of uid' do
      user = User.new(email: 'test@example.com', provider: 'google_oauth2')
      expect(user).not_to be_valid
      expect(user.errors[:uid]).to include("can't be blank")
    end

    it 'is valid with all required attributes' do
      user = User.new(
        email: 'test@example.com',
        name: 'Test User',
        provider: 'google_oauth2',
        uid: '123'
      )
      expect(user).to be_valid
    end
  end

  describe 'OAuth user creation' do
    let(:auth_hash) do
      OmniAuth::AuthHash.new({
        'provider' => 'google_oauth2',
        'uid' => '123456789',
        'info' => {
          'name' => 'John Doe',
          'email' => 'john@example.com'
        }
      })
    end

    it 'creates user from OAuth data' do
      expect {
        User.find_or_create_from_oauth(auth_hash)
      }.to change(User, :count).by(1)

      user = User.last
      expect(user.email).to eq('john@example.com')
      expect(user.name).to eq('John Doe')
      expect(user.provider).to eq('google_oauth2')
      expect(user.uid).to eq('123456789')
    end

    it 'finds existing user from OAuth data' do
      existing_user = User.create!(
        email: 'john@example.com',
        name: 'John Doe',
        provider: 'google_oauth2',
        uid: '123456789'
      )

      expect {
        User.find_or_create_from_oauth(auth_hash)
      }.not_to change(User, :count)

      user = User.find_or_create_from_oauth(auth_hash)
      expect(user).to eq(existing_user)
    end
  end

  describe 'Application controller helpers' do
    let(:user) do
      User.create!(
        email: 'test@example.com',
        name: 'Test User',
        provider: 'google_oauth2',
        uid: '123'
      )
    end

    it 'has authenticate_user! helper (private method)' do
      expect(ApplicationController.private_instance_methods).to include(:authenticate_user!)
    end

    it 'has user_signed_in? helper (helper method)' do
      expect(ApplicationController._helper_methods).to include(:user_signed_in?)
    end

    it 'has current_user helper (private method)' do
      expect(ApplicationController.private_instance_methods).to include(:current_user)
    end
  end
end
