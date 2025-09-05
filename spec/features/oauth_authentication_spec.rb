require 'rails_helper'

RSpec.feature 'OAuth Authentication', type: :feature do
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
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
  end

  after do
    OmniAuth.config.test_mode = false
  end

  scenario 'User signs in with Google OAuth' do
    visit login_path

    expect(page).to have_content('Sign in with Google')
    expect(page).to have_link('Sign in with Google', href: '/auth/google_oauth2')

    # Use the link in the main content area, not the header
    within('.shadow.rounded-lg.bg-white') do
      click_link 'Sign in with Google'
    end

    expect(page).to have_current_path(welcome_path)
    expect(page).to have_content('Welcome, John Doe!')
    expect(page).to have_content('Successfully signed in!')
  end

  scenario 'User signs out' do
    # First sign in
    visit login_path
    within('.shadow.rounded-lg.bg-white') do
      click_link 'Sign in with Google'
    end

    expect(page).to have_current_path(welcome_path)

    # Then sign out - use the delete method
    within('.mt-6.text-center') do
      click_link 'Sign Out'
    end

    expect(page).to have_current_path(login_path)
    expect(page).to have_content('Successfully signed out!')
  end

  scenario 'User tries to access welcome page without authentication' do
    visit welcome_path

    expect(page).to have_current_path(login_path)
    expect(page).to have_content('Please sign in to access this page.')
  end

  scenario 'User switches language' do
    visit login_path

    # Switch to Vietnamese
    click_link 'VI'
    expect(page).to have_current_path(login_path)

    # Switch to Japanese
    click_link 'JA'
    expect(page).to have_current_path(login_path)

    # Switch back to English
    click_link 'EN'
    expect(page).to have_current_path(login_path)
  end

  scenario 'User views terms and privacy page' do
    visit login_path

    click_link 'terms and privacy policy'

    expect(page).to have_current_path(legal_path)
    expect(page).to have_content('Terms of Service')
    expect(page).to have_content('Privacy Policy')
  end

  scenario 'User returns to login from legal page' do
    visit legal_path

    click_link 'Back to Login'

    expect(page).to have_current_path(login_path)
  end

  scenario 'User sees localized content' do
    visit login_path

    # Check English content
    expect(page).to have_content('Sign in with Google')
    expect(page).to have_content('Welcome to RSpec Boilerplate')

    # Switch to Vietnamese
    click_link 'VI'
    expect(page).to have_content('Đăng nhập bằng Google')
    expect(page).to have_content('Chào mừng đến với RSpec Boilerplate')

    # Switch to Japanese
    click_link 'JA'
    expect(page).to have_content('Googleでサインイン')
    expect(page).to have_content('RSpec Boilerplateへようこそ')
  end

  scenario 'User sees welcome page content' do
    visit login_path
    within('.shadow.rounded-lg.bg-white') do
      click_link 'Sign in with Google'
    end

    expect(page).to have_content('Welcome, John Doe!')
    expect(page).to have_content('🚀 Your Account')
    expect(page).to have_content('📱 Smartphone API')
    expect(page).to have_content('🔧 Development Features')
    expect(page).to have_content('Sign Out')
  end

  scenario 'User sees application header with logo' do
    visit login_path

    expect(page).to have_css('svg') # Logo
    expect(page).to have_content('RSpec Boilerplate - Operator Page')
  end

  scenario 'User sees browser tab title' do
    visit login_path

    expect(page).to have_title('RSpec Boilerplate - Operator Page')
  end
end
