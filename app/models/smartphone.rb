class Smartphone < ApplicationRecord
  belongs_to :smartphone_model
  belongs_to :model_option

  validates :imei, presence: true
end
