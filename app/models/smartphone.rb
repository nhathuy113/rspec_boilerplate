class Smartphone < ApplicationRecord
  belongs_to :model_option
  # has_one :smartphone_model, through: :model_option


  validates :imei, presence: true, format: { with: /\A[0-9A-Za-z]{8,20}\z/, message: 'IMEI must be 8-20 alphanumeric characters' }
end

