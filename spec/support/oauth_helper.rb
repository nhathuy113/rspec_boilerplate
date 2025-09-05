module OAuthHelper
  def mock_oauth_auth(user_attributes = {})
    auth_hash = {
      'provider' => 'google_oauth2',
      'uid' => '123456789',
      'info' => {
        'name' => user_attributes[:name] || 'John Doe',
        'email' => user_attributes[:email] || 'john@example.com'
      }
    }

    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
  end

  def sign_in_via_oauth(user_attributes = {})
    mock_oauth_auth(user_attributes)
    get '/auth/google_oauth2/callback'
    follow_redirect! if response.redirect?
  end

  def sign_in_via_oauth_feature(user_attributes = {})
    mock_oauth_auth(user_attributes)
    visit '/auth/google_oauth2/callback'
  end
end

RSpec.configure do |config|
  config.include OAuthHelper, type: :request
  config.include OAuthHelper, type: :feature
end
