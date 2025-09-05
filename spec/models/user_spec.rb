require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_uniqueness_of(:uid).scoped_to(:provider).case_insensitive }
  end

  describe '.find_or_create_from_oauth' do
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

    context 'when user does not exist' do
      it 'creates a new user' do
        expect {
          User.find_or_create_from_oauth(auth_hash)
        }.to change(User, :count).by(1)

        user = User.last
        expect(user.email).to eq('john@example.com')
        expect(user.name).to eq('John Doe')
        expect(user.provider).to eq('google_oauth2')
        expect(user.uid).to eq('123456789')
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

      it 'returns the existing user' do
        expect {
          User.find_or_create_from_oauth(auth_hash)
        }.not_to change(User, :count)

        user = User.find_or_create_from_oauth(auth_hash)
        expect(user).to eq(existing_user)
      end
    end

    context 'when auth hash is missing required data' do
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

      it 'raises an error' do
        expect {
          User.find_or_create_from_oauth(invalid_auth_hash)
        }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'creates a user with required attributes' do
      user = create(:user)
      
      expect(user.email).to be_present
      expect(user.name).to be_present
      expect(user.provider).to eq('google_oauth2')
      expect(user.uid).to be_present
    end
  end
end
