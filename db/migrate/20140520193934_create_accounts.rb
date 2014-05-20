class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true
      t.decimal :current_amount, precision: 10, scale: 2
      t.string :number

      t.timestamps
    end
  end
end
