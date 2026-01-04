class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string  :name, null: false
      t.string  :product_code, null: false, index: { unique: true }
      t.integer :stock, null: false, default: 0
      t.decimal :unit_price, precision: 10, scale: 2, null: false
      t.decimal :tax_percentage, precision: 5, scale: 2, null: false

      t.timestamps
    end
  end
end
