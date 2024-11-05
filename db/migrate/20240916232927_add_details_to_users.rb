class AddDetailsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string, default: 'client', null: false
    add_column :users, :identification, :string, limit: 18
  end
end
