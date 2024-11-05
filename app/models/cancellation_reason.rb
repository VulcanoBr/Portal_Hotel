class CancellationReason < ApplicationRecord

  has_many :reservations

  validates :name, :description,  presence: true

  scope :active, -> { where(active: true) }
  scope :ordered_by_name, -> { order(:name) }

  # Combinação de scopes (opcional)
  scope :active_ordered, -> { active.ordered_by_name }

end
