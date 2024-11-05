class Payment < ApplicationRecord

  belongs_to :reservation

  monetize :total_value_cents

end
