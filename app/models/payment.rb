class Payment < ApplicationRecord

  validates :name, :number, :due_date, :cvc, :amount, presence: true
end
