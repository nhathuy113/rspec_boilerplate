# spec/controllers/smartphones_controller_spec.rb

require 'rails_helper'

# describe 'SmartphonesController', type: :controller do
describe SmartphonesController, type: :controller do
  let(:valid_params) do
    {
      smartphone: {
        manufacturer_id: 1,
        model_id: 1,
        memory_id: 1,
        year_id: 1,
        os_version_id: 1,
        body_color_id: 1,
        price: 999
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
