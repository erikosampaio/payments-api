namespace :admin do
  desc 'Generate payments'
  task generate_payments: :environment do
    p 'Generating payments...'
    10.times do
      Payment.create!(
        name: Faker::Name.name,
        number: Faker::Number.number(digits: 16),
        due_date: Faker::Date.forward(days: 30),
        cvc: Faker::Number.number(digits: 3),
        amount: Faker::Number.decimal(l_digits: 2)
      )
    end
    p 'Payments generated successfully!'
  end
end
