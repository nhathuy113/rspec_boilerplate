class Smartphone < ApplicationRecord
  belongs_to :model_option
  # has_one :smartphone_model, through: :model_option

  validates :imei, presence: true
end
