class AddMonetizeToResrevations < ActiveRecord::Migration[7.2]
  def change
    add_monetize :reservations, :daily_price
    add_monetize :reservations, :total_daily
  end
end
