class SmartphonesController < ApplicationController
  # before_action :is_login
  # before_action :is_authorized

  def create
    # Find or create model_option based on the provided parameters
    model_option = ModelOption.find_or_create_by!(
      smartphone_model_id: params[:smartphone][:model_id],
      body_color_id: params[:smartphone][:body_color_id],
      memory_id: params[:smartphone][:memory_id]
    )

    smartphone = Smartphone.new(
      imei: smartphone_params[:imei],
      model_option_id: model_option.id
    )

    if smartphone.save
      render json: smartphone, status: :created
    else
      render json: smartphone.errors, status: :unprocessable_entity
    end
  end

  private

  def smartphone_params
    params.require(:smartphone).permit(:imei, :model_id, :body_color_id, :memory_id)
  end
end
