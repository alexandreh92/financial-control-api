class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.references :bank, null: false, foreign_key: true
      t.string :number, null: false

      t.timestamps
    end

    add_index :accounts, :number, unique: true
  end
end
