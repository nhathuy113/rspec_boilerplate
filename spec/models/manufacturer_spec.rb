require 'rails_helper'

RSpec.describe Brand, type: :model do
  it 'has many smartphone_models' do
    expect(described_class.reflect_on_association(:smartphone_models).macro).to eq(:has_many)
  end
end
