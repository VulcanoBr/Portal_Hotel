class CreatePayments < ActiveRecord::Migration[7.2]
  def change
    create_table :payments do |t|
      t.references :reservation, null: false, foreign_key: true
      t.string :payment_method
      t.string :installments
      t.string :boleto_barcode
      t.string :pix_code

      t.timestamps
    end
  end
end
