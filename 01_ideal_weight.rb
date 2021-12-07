# frozen_string_literal: true

class IdealWeight
  puts 'Enter your name:'
  name = gets.chomp

  puts 'Enter your height:'
  height = gets.chomp.to_i

  ideal_weight = height - 110

  if ideal_weight >= 0
    puts "#{name}, your ideal weight should be #{ideal_weight} kg."
  elsif ideal_weight.negative?
    puts 'You already have optimal weight!'
  else
    puts "#{name}, sorry, but you entered an invalid height value(#{height})!"
  end
end
