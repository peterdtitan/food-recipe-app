class Food < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :user, :name, :price, :measurement_unit, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
