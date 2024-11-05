class CreateRoomTypes < ActiveRecord::Migration[7.2]
  def change
    create_table :room_types do |t|
      t.string :description

      t.timestamps
    end
  end
end
