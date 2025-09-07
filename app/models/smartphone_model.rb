class SmartphoneModel < ApplicationRecord
  has_many :model_options
  has_many :smartphones, through: :model_options

  belongs_to :brand
  belongs_to :year
  belongs_to :os_version

  validates :name, presence: true
  validate :apple_models_must_use_ios

  private

  APPLE = 'Apple'
  def apple_models_must_use_ios
    return true if brand.nil? || os_version.nil?
    return true unless brand.name == APPLE

    if os_version.version.nil? || !os_version.version.start_with?('iOS')
      errors.add(:os_version, 'Apple models must use iOS.')
    end
  end
end
