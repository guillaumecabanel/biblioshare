class CreateLoans < ActiveRecord::Migration[6.1]
  def change
    create_table :loans do |t|
      t.references :lender, null: false, foreign_key: { to_table: :users }
      t.references :borrower, null: false, foreign_key: { to_table: :users }
      t.string :isbn
      t.string :title
      t.string :author

      t.timestamps
    end
  end
end
