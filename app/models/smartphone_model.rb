class SmartphoneModel < ApplicationRecord
  has_many :model_options
  has_many :smartphones, through: :model_options

  belongs_to :brand
  belongs_to :year
  belongs_to :os_version

  validates :name, presence: true
  validate :apple_models_must_use_ios

  private

  APPLE = 'APPLE'
  def apple_models_must_use_ios
    return true if brand.name != APPLE
    # if brand.name == 'Apple' && os_version.name != 'iOS'
    if brand.name == APPLE and not os_version.name.start_with? 'iOS'
      errors.add(:operating_system, 'Apple models must use iOS.')
    end
  end
end
