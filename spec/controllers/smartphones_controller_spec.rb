# spec/controllers/smartphones_controller_spec.rb

require 'rails_helper'

# describe 'SmartphonesController', type: :controller do
describe SmartphonesController, type: :controller do
  let(:smartphone_model) { create(:smartphone_model) }
  let(:body_color) { create(:body_color) }
  let(:memory) { create(:memory) }
  
  let(:valid_params) do
    {
      smartphone: {
        model_id: smartphone_model.id,
        memory_id: memory.id,
        body_color_id: body_color.id,
        imei: '123456789012345'
      }
    }
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new smartphone' do
        expect do
          post :create, params: valid_params
        end.to change(Smartphone, :count).by(1)
        expect(response).to have_http_status(:created)
      end
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
