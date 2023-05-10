class CreatePayees < ActiveRecord::Migration[7.0]
  def change
    create_table :payees do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :payees, :name, unique: true
  end
end
