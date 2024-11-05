class AddTotalValueToPayments < ActiveRecord::Migration[7.2]
  def change
    add_monetize :payments, :total_value
  end
end
