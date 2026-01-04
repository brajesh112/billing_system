class CreatePurchaseItems < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_items do |t|
      t.references :purchase, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :tax_amount, precision: 10, scale: 2, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
