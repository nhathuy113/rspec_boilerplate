require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'GET #create' do
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

    before do
      request.env['omniauth.auth'] = auth_hash
    end

    context 'when user does not exist' do
      it 'creates a new user and signs them in' do
        expect {
          get :create, params: { provider: 'google_oauth2' }
        }.to change(User, :count).by(1)

        expect(session[:user_id]).to eq(User.last.id)
        expect(response).to redirect_to(welcome_path)
        expect(flash[:notice]).to eq(I18n.t('sessions.sign_in_success'))
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

      it 'finds existing user and signs them in' do
        expect {
          get :create, params: { provider: 'google_oauth2' }
        }.not_to change(User, :count)

        expect(session[:user_id]).to eq(existing_user.id)
        expect(response).to redirect_to(welcome_path)
        expect(flash[:notice]).to eq(I18n.t('sessions.sign_in_success'))
      end
    end

    context 'when OAuth data is invalid' do
      let(:invalid_auth_hash) do
        {
          'provider' => 'google_oauth2',
          'uid' => nil,
          'info' => {
            'name' => nil,
            'email' => nil
          }
        }
      end

      before do
        request.env['omniauth.auth'] = invalid_auth_hash
      end

      it 'redirects to login with error message' do
        get :create, params: { provider: 'google_oauth2' }

        expect(response).to redirect_to(login_path)
        expect(flash[:alert]).to eq(I18n.t('sessions.auth_failed'))
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }

    before do
      session[:user_id] = user.id
    end

    it 'clears the session and redirects to login' do
      delete :destroy

      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
              expect(flash[:notice]).to eq(I18n.t('sessions.sign_out_success'))
    end
  end

  describe 'GET #failure' do
    it 'redirects to login with error message' do
      get :failure

      expect(response).to redirect_to(login_path)
              expect(flash[:alert]).to eq(I18n.t('sessions.auth_failed_retry'))
    end
  end
end
