class Amenity < ApplicationRecord

  has_and_belongs_to_many :hotels

  validates :description, presence: true, uniqueness: true

end
