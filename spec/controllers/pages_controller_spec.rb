require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe 'GET #login' do
    context 'when user is not signed in' do
      it 'renders the login page' do
        get :login

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:login)
      end
    end

    context 'when user is already signed in' do
      let(:user) { create(:user) }

      before do
        session[:user_id] = user.id
      end

      it 'redirects to welcome page' do
        get :login

        expect(response).to redirect_to(welcome_path)
      end
    end
  end

  describe 'GET #welcome' do
    context 'when user is signed in' do
      let(:user) { create(:user) }

      before do
        session[:user_id] = user.id
      end

      it 'renders the welcome page' do
        get :welcome

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:welcome)
      end
    end

    context 'when user is not signed in' do
      it 'redirects to login page' do
        get :welcome

        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'GET #legal' do
    it 'renders the legal page' do
      get :legal

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:legal)
    end
  end
end
