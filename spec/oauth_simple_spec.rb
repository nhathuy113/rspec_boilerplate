require 'rails_helper'

RSpec.describe 'OAuth Simple Test' do
  it 'User model exists' do
    expect(User).to be_a(Class)
  end

  it 'User model has validations' do
    user = User.new
    expect(user).not_to be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end

  it 'User can be created with valid attributes' do
    user = User.new(
      email: 'test@example.com',
      name: 'Test User',
      provider: 'google_oauth2',
      uid: '123'
    )
    expect(user).to be_valid
  end

  it 'ApplicationController has authentication helpers' do
    # Test that the methods exist on the controller class
    expect(ApplicationController.private_instance_methods).to include(:current_user)
    expect(ApplicationController.private_instance_methods).to include(:authenticate_user!)
    expect(ApplicationController._helper_methods).to include(:user_signed_in?)
  end
end
