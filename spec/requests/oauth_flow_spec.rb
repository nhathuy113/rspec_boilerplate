require 'rails_helper'

RSpec.describe 'OAuth Flow', type: :request do
  let(:auth_hash) do
    {
      'provider' => 'google_oauth2',
      'uid' => '123456789',
      'info' => {
        'name' => 'John Doe',
        'email' => 'john@example.com'
      }
    }
  end

  describe 'OAuth authentication flow' do
    describe 'GET /login' do
      it 'renders login page' do
        get login_path

        expect(response).to have_http_status(:success)
        expect(response.body).to include('Sign in with Google')
      end

      context 'when user is already signed in' do
        before do
          OmniAuth.config.test_mode = true
          OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
          get '/auth/google_oauth2/callback'
          follow_redirect!
        end

        after do
          OmniAuth.config.test_mode = false
        end

        it 'redirects to welcome page' do
          get login_path

          expect(response).to redirect_to(welcome_path)
        end
      end
    end

    describe 'GET /auth/:provider/callback' do
      before do
        OmniAuth.config.test_mode = true
        OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
      end

      after do
        OmniAuth.config.test_mode = false
      end

      context 'when OAuth is successful' do
        it 'creates user and redirects to welcome' do
          expect {
            get '/auth/google_oauth2/callback'
          }.to change(User, :count).by(1)

          expect(response).to redirect_to(welcome_path)
          expect(flash[:notice]).to eq(I18n.t('sessions.sign_in_success'))
        end

        it 'sets session user_id' do
          get '/auth/google_oauth2/callback'

          expect(session[:user_id]).to eq(User.last.id)
        end
      end

      context 'when user already exists' do
        let!(:existing_user) do
          User.create!(
            email: 'john@example.com',
            name: 'John Doe',
            provider: 'google_oauth2',
            uid: '123456789'
          )
        end

        it 'finds existing user and redirects to welcome' do
          expect {
            get '/auth/google_oauth2/callback'
          }.not_to change(User, :count)

          expect(response).to redirect_to(welcome_path)
          expect(session[:user_id]).to eq(existing_user.id)
        end
      end
    end

    describe 'GET /auth/failure' do
      it 'redirects to login with error message' do
        get '/auth/failure'

        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq(I18n.t('sessions.auth_failed_retry'))
      end
    end
  end

  describe 'Protected pages' do
    describe 'GET /welcome' do
      context 'when user is not signed in' do
        it 'redirects to login' do
          get welcome_path

          expect(response).to redirect_to(login_path)
        end
      end

      context 'when user is signed in' do
        before do
          OmniAuth.config.test_mode = true
          OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
          get '/auth/google_oauth2/callback'
        end

        after do
          OmniAuth.config.test_mode = false
        end

        it 'renders welcome page' do
          get welcome_path

          expect(response).to have_http_status(:success)
          expect(response.body).to include('Welcome')
        end
      end
    end
  end

  describe 'Session management' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
      get '/auth/google_oauth2/callback'
    end

    after do
      OmniAuth.config.test_mode = false
    end

    describe 'DELETE /sign_out' do
      it 'clears session and redirects to login' do
        delete sign_out_path

        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq(I18n.t('sessions.sign_out_success'))
      end
    end

    describe 'GET /sign_out' do
      it 'clears session and redirects to login' do
        get sign_out_path

        expect(session[:user_id]).to be_nil
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq(I18n.t('sessions.sign_out_success'))
      end
    end
  end
end
