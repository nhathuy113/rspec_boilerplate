class SmartphoneModel < ApplicationRecord
  has_many :model_options
  has_many :smartphones, through: :model_options

  belongs_to :brand
  belongs_to :year
  belongs_to :os_version

  validates :name, presence: true
end
