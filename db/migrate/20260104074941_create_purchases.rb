class CreatePurchases < ActiveRecord::Migration[8.0]
  def change
    create_table :purchases do |t|
      t.references :customer, null: false, foreign_key: true
      t.decimal :total_without_tax, precision: 10, scale: 2, null: false
      t.decimal :total_tax, precision: 10, scale: 2, null: false
      t.decimal :total_with_tax, precision: 10, scale: 2, null: false
      t.decimal :rounded_total, precision: 10, scale: 2, null: false
      t.decimal :paid_amount, precision: 10, scale: 2, null: false
      t.decimal :balance_amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
