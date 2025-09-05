require 'capybara/rspec'

Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.default_driver = :rack_test

  # config.javascript_driver = :rack_test
  
  # Capybara.javascript_driver = :selenium_chrome_headless
  config.javascript_driver = :selenium_chrome_headless
  
  
  # Allow all hosts in test environment
  config.server_host = 'localhost'
  config.app_host = 'http://localhost'
  
  # Increase timeout for slower operations
  config.default_max_wait_time = 5
end

# Configure RSpec to use Capybara
RSpec.configure do |config|
  config.before(:each, type: :feature) do
    Capybara.current_driver = :rack_test
    Capybara.current_driver = :selenium_chrome_headless
  end

  config.after(:each, type: :feature) do
    Capybara.use_default_driver
  end
end
