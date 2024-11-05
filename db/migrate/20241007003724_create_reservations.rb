class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :hotel, null: false, foreign_key: true
      t.references :room, null: false, foreign_key: true
      t.string :reservation_code, null: false
      t.date :check_in_date, null: false
      t.date :check_out_date, null: false
      t.string :status, null: false, default: 'reserved'
      t.references :cancellation_reason, null: true, foreign_key: true

      t.timestamps
    end
  end
end
