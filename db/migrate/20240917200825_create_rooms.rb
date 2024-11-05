class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :rooms do |t|
      t.integer :room_number
      t.integer :floor_number
      t.string :description
      t.string :status, default: 'available'
      t.references :hotel, null: false, foreign_key: true
      t.references :room_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
