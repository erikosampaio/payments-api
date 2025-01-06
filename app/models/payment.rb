class Payment < ApplicationRecord

  enum status: [:pending, :paid]

  validates :name, :number, :due_date, :cvc, :amount, presence: true
  validates :number, length: { is: 16 }
end
