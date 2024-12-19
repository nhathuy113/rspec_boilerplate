class SmartphonesController < ApplicationController
  # before_action :is_login
  # before_action :is_authorized

  def create
    smartphone = Smartphone.new(smartphone_params)

    ## Note: the author deeply recommend a validation gem or moving code to validation class for DRY and future upgrade/expansion
    ## This fat controller method serve as demo for coding test or POC only.
    errors = []
    errors.push I18n.t("errors.smartphones.invalid_reference.manufacturer") unless Manufacturer.exists?(smartphone.manufacturer_id)
    errors.push I18n.t("errors.smartphones.invalid_reference.model") unless SmartphoneModel.exists?(smartphone.model_id)
    errors.push I18n.t("errors.smartphones.invalid_reference.memory") unless Memory.exists?(smartphone.memory_id)
    errors.push I18n.t("errors.smartphones.invalid_reference.year") unless Year.exists?(smartphone.year_id)
    errors.push I18n.t("errors.smartphones.invalid_reference.os_version") unless OsVersion.exists?(smartphone.os_version_id)
    errors.push I18n.t("errors.smartphones.invalid_reference.body_color") unless BodyColor.exists?(smartphone.body_color_id)
    if errors.any?
      render json: errors, status: :not_found
      return
    end

    if smartphone.manufacturer_id != SmartphoneModel.find(smartphone.model_id).manufacturer_id
      errors.push I18n.t("errors.smartphones.not_match_manufacturer")
    end
    # if smartphone.price.blank? or not smartphone.price.kind_of? Integer
    #   errors.push I18n.t("errors.smartphones.price_not_float")
    # end

    if errors.any?
      render json: errors, status: :unprocessable_entity
      return
    end

    if smartphone.save
      # SmartphoneModel.find(smartphone.model_id).update(manufacturer_id: smartphone.manufacturer_id)
      render json: smartphone, status: :created
    else
      render json: smartphone.errors, status: :unprocessable_entity
    end
  end

  private

  def smartphone_params
    params.require(:smartphone).permit(:manufacturer_id, :model_id, :memory_id, :year_id, :os_version_id, :body_color_id, :price)
  end
end