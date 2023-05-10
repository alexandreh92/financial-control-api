class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :external_id, null: false
      t.integer :transaction_type, null: false
      t.decimal :amount, null: false, precision: 15, scale: 0
      t.string :memo, null: false
      t.date :date, null: false

      t.references :payee, null: false, foreign_key: true
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end

    add_index :transactions, %i[external_id account_id], unique: true
  end
end
