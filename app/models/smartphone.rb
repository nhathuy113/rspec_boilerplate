class Smartphone < ApplicationRecord
  belongs_to :smartphone_model
  belongs_to :smartphone_option

  validates :imei, presence: true
end
