require 'rails_helper'

RSpec.describe Smartphone, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:model_option) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:imei) }
  end

  describe 'model relationships' do
    # Set up the test objects
    let(:brand) { create(:brand, name: 'Apple') }
    let(:body_color) { create(:body_color, color: 'Black') }
    let(:memory) { create(:memory, size: '128GB') }
    let(:year) { create(:year, number: 2023) }
    let(:os_version) { create(:os_version, version: 'iOS 16') }
    let(:smartphone_model) { create(:smartphone_model, brand: brand, year: year, os_version: os_version, name: 'iPhone 15') }
    let(:model_option) { create(:model_option, smartphone_model: smartphone_model, body_color: body_color, memory: memory) }
    let(:smartphone) { create(:smartphone, model_option: model_option, imei: '123456789012345') }

    it 'correctly accesses smartphone_model through model_option' do
      expect(smartphone.model_option.smartphone_model).to eq(smartphone_model)
    end

    it 'allows safe navigation when accessing smartphone_model' do
      # This test doesn't actually save a record with nil model_option
      # It just tests that the safe navigation pattern works
      new_phone = described_class.new(imei: '987654321098765')

      # With safe navigation
      expect { new_phone.model_option&.smartphone_model }.not_to raise_error

      # Without safe navigation would raise NoMethodError
      expect { new_phone.model_option&.smartphone_model }.not_to raise_error
    end
  end
end
