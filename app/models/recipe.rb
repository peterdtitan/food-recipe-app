class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods

  validates :name, :description, presence: true
  validates :preparation_time, :cooking_time, numericality: { greater_than_or_equal_to: 0 }
  validates :public, inclusion: { in: [true, false], message: 'It should be true or false' }
end
