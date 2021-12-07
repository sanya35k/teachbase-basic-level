# frozen_string_literal: true

class QuadraticEquation
  puts 'Enter the coefficient a:'
  a = gets.chomp.to_f
  puts 'Enter the coefficient b:'
  b = gets.chomp.to_f
  puts 'Enter the coefficient c:'
  c = gets.chomp.to_f

  d = -4 * a * c + b**2

  if d.positive?
    x1 = (-b + Math.sqrt(d)) / (2 * a)
    x2 = (-b - Math.sqrt(d)) / (2 * a)
    puts "x1 = #{x1}, x2 = #{x2}. D = #{d}"
  elsif d.zero?
    x12 = (-b) / (2 * a)
    puts "x12 = #{x12}. D = #{d}"
  else
    puts 'The equation has no roots!'
  end
end
