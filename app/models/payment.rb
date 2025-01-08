class Payment < ApplicationRecord

  enum status: [:pending, :paid]

  validates :name, :number, :amount, :status, presence: true
  validates :number, length: { is: 16 }

  def self.providers
    [:pag_seguro, :mercado_pago]
  end
end
