# frozen_string_literal: true

class CheckRectangularTriangle
  puts 'Enter the side a:'
  a = gets.chomp.to_f
  puts 'Enter the side b:'
  b = gets.chomp.to_f
  puts 'Enter the side c:'
  c = gets.chomp.to_f

  sides = [a, b, c].sort
  figure = 'Triangle'

  if sides[2]**2 == sides[1]**2 + sides[0]**2
    figure += ' rectangular'

    figure += if sides.uniq.size == 2
                ' isosceles.'
              else
                '.'
              end

  elsif ((sides[0] + sides[1]) < sides[2]) || ((sides[0] + sides[2]) < sides[1]) || ((sides[1] + sides[2]) < sides[0])
    figure += ' does not exist!'

  else
    figure += ' is not rectangular'

    figure += case sides.uniq.size
              when 1
                ', but equilateral!'
              when 2
                ', but isosceles!'
              else
                '!'
              end
  end

  puts figure
end
