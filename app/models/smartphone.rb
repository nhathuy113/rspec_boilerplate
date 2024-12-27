class Smartphone < ApplicationRecord
  belongs_to :manufacturer
  belongs_to :smartphone_model
  belongs_to :memory
  belongs_to :year
  belongs_to :os_version
  belongs_to :body_color
end
