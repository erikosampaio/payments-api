class PaymentSerializer
  include JSONAPI::Serializer
  attributes :name, :number, :amount, :status

  attribute :number do |object|
    object.number[-4..-1]
  end

  attribute :amount do |object|
    object.amount.to_f
  end
end
