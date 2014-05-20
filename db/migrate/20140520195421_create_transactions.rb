class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :sender, references: :users, index: true
      t.references :receiver, references: :users, index: true
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
