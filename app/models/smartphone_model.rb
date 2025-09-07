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
    return unless brand&.name == APPLE
    errors.add(:os_version, 'Apple models must use iOS.') unless os_version&.version&.start_with?('iOS')
  end
end
