class Brand < ApplicationRecord
  has_many :smartphone_models
  has_many :smartphones, through: :smartphone_models

  def is_apple?
    name == SmartphoneModel.APPLE
  end
end
