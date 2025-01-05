class SmartphoneModel < ApplicationRecord
  belongs_to :year
  belongs_to :os_version
  belongs_to :brand

  has_many :model_options
  has_many :smartphones, through: :smartphone_options

  validates :name, presence: true
end
