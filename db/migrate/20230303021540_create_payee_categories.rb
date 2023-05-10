class CreatePayeeCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :payee_categories do |t|
      t.references :payee, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_index :payee_categories, %i[payee_id category_id], unique: true
  end
end
