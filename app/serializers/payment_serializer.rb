class PaymentSerializer
  include JSONAPI::Serializer
  attributes :name, :amount, :status

  attribute :number do |object|
    object.number[-4..-1]
  end
end
