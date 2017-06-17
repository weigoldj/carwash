class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.string :license_plate
      t.decimal :cost

      t.timestamps
    end
  end
end
