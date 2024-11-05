class CreateJoinTableHotelsAmenities < ActiveRecord::Migration[7.2]
  def change
    create_join_table :hotels, :amenities do |t|
      t.index [:hotel_id, :amenity_id]
      t.index [:amenity_id, :hotel_id]
    end
  end
end
