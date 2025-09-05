class ModelOption < ApplicationRecord
  belongs_to :body_color
  belongs_to :memory

  belongs_to :smartphone_model
  has_many :smartphones
end
