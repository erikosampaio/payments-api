class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :number
      t.datetime :due_date
      t.string :cvc
      t.decimal :amount, precision: 10, scale: 2

      t.timestamps
    end
  end
end
