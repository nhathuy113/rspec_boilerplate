class Smartphone < ApplicationRecord
  # belongs_to :smartphone_model, through: :model_option
  delegate :smartphone_model, to: :model_option, allow_nil: false

  belongs_to :model_option

  validates :imei, presence: true
end
