class CreateCancellationReasons < ActiveRecord::Migration[7.2]
  def change
    create_table :cancellation_reasons do |t|
      t.string :name, null: true
      t.text :description
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
