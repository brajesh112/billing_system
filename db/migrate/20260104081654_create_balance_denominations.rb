class CreateBalanceDenominations < ActiveRecord::Migration[8.0]
  def change
    create_table :balance_denominations do |t|
      t.references :purchase, null: false, foreign_key: true
      t.integer :denomination_value
      t.integer :count

      t.timestamps
    end
  end
end
