class CreateDenominations < ActiveRecord::Migration[8.0]
  def change
    create_table :denominations do |t|
      t.integer :value
      t.integer :available_count

      t.timestamps
    end
  end
end
