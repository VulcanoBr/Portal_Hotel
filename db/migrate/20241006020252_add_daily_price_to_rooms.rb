class AddDailyPriceToRooms < ActiveRecord::Migration[7.2]
  def change
    add_monetize :rooms, :daily_price
  end
end
