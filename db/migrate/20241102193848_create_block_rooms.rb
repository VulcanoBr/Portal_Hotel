class CreateBlockRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :block_rooms do |t|
      t.references :room, null: false, foreign_key: true
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :reason, null: false
      t.date :finished_at
      t.string :status, null: false, default: 'inprogress'

      t.timestamps
    end
  end
end
