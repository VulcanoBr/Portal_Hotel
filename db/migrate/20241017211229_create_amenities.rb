class CreateAmenities < ActiveRecord::Migration[7.2]
  def change
    create_table :amenities do |t|
      t.string :description, null: false

      t.timestamps
    end
  end
end