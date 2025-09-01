require 'rails_helper'

RSpec.describe 'Simple Test' do
  it 'should work' do
    expect(1 + 1).to eq(2)
  end

  it 'should have Rails environment' do
    expect(Rails.env).to eq('development')
  end
end
