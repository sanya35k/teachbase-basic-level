# frozen_string_literal: true

class AmountPurchases
  basket = {}

  loop do
    puts 'Enter product name:'
    name = gets.chomp
    break if name == 'stop'

    puts 'Enter the unit price:'
    price = gets.chomp.to_f
    puts 'Enter product quantity:'
    quantity = gets.chomp.to_f

    basket[name] = {
      price: price,
      quantity: quantity,
      total_price: price * quantity
    }
  end

  basket_price = 0
  basket.each { |_, value| basket_price += value[:total_price] }

  p basket
  p "Цена за все: #{basket_price}"
end
