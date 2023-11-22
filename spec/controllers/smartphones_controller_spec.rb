# spec/controllers/smartphones_controller_spec.rb

require 'rails_helper'

# describe 'SmartphonesController', type: :controller do
describe SmartphonesController, type: :controller do
<<<<<<< HEAD
  let!(:brand) { create(:brand) }
  let!(:year) { create(:year) }
  let!(:os_version) { create(:os_version) }
  let!(:smartphone_model) { create(:smartphone_model, brand: brand, year: year, os_version: os_version) }
  let!(:body_color) { create(:body_color) }
  let!(:memory) { create(:memory) }
  let!(:model_option) { create(:model_option, smartphone_model: smartphone_model, body_color: body_color, memory: memory) }

  let(:valid_params) do
    {
      smartphone: {
        model_option_id: model_option.id,
        imei: 'A12345678901234'
      }
    }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new smartphone' do
        expect {
          post :create, params: valid_params
        }.to change(Smartphone, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      # it 'redirects to the created smartphone' do
      #   post :create, params: valid_params
      #   expect(response).to redirect_to(Smartphone.last)
      # end
    end

    # context 'with invalid parameters' do
    #   let(:invalid_params) do
    #     {
    #       smartphone: {
    #         manufacturer_id: 1,
    #         model_id: 1,
    #         memory_id: 1,
    #         year_id: 1,
    #         os_version_id: 1,
    #         body_color_id: 1,
    #         price: nil
    #       }
    #     }
    #   end
    #
    #   it 'does not create a new smartphone' do
    #     expect {
    #       post :create, params: invalid_params
    #     }.not_to change(Smartphone, :count)
    #   end
    #
    #   it 'renders the new template' do
    #     post :create, params: invalid_params
    #     expect(response).to render_template(:new)
    #   end
    # end
  end
end