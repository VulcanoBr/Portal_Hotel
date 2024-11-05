class CreateHotels < ActiveRecord::Migration[7.2]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :title
      t.string :location
      t.string :email
      t.string :telephone
      t.text :description
      t.integer :total_rooms
      t.integer :floors
      t.integer :max_rooms_per_floor
      t.string :address_zip_code, limit: 9
      t.string :address_state, limit: 2
      t.string :address_city
      t.string :address_neighborhood
      t.string :address_street
      t.string :address_number
      t.string :address_complement

      t.timestamps
    end
  end
end
