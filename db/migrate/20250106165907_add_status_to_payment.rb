class AddStatusToPayment < ActiveRecord::Migration[7.1]
  def change
    add_column :payments, :status, :integer, default: 0
  end
end
