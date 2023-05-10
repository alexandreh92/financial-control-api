class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :name, null: false
      t.integer :external_id, null: false

      t.timestamps
    end

    add_index :banks, :external_id, unique: true
  end
end
