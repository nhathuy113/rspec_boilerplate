class SmartphonesController < ApplicationController
  # before_action :is_login
  # before_action :is_authorized

  def create
    smartphone = Smartphone.new(smartphone_params)

    errors = []
    unless ModelOption.exists?(smartphone.model_option_id)
      errors.push I18n.t("errors.smartphones.invalid_reference.model_option", default: "Invalid model option")
    end

    if errors.any?
      render json: errors, status: :not_found
      return
    end

    if smartphone.save
      render json: smartphone, status: :created
    else
      render json: smartphone.errors, status: :unprocessable_entity
    end
  end

  private

  def smartphone_params
    params.require(:smartphone).permit(:model_option_id, :imei)
  end
end