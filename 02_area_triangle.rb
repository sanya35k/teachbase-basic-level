# frozen_string_literal: true

class AreaTriangle
  puts 'Enter the base of the triangle(a):'
  a = gets.chomp.to_f
  puts 'Enter the height of the triangle(h):'
  h = gets.chomp.to_f

  if (a && h).positive?
    sum = 0.5 * a * h
    puts "The area of the triangle is equal #{sum}"
  else
    puts 'Error! You entered an invalid height value!'
  end
end
