# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           ENV.fetch('GOOGLE_CLIENT_ID', 'test_client_id'),
           ENV.fetch('GOOGLE_CLIENT_SECRET', 'test_client_secret'),
           {
             prompt: 'consent',
             access_type: 'offline',
             scope: 'email,profile'
           }
end

# In development, permit GET auth requests for convenience
if Rails.env.development? || Rails.env.test?
  OmniAuth.config.allowed_request_methods = %i[get post]
  OmniAuth.config.silence_get_warning = true
end

# Ensure OmniAuth raises on failures (handled by failure route)
OmniAuth.config.on_failure = proc { |env| SessionsController.action(:failure).call(env) }


