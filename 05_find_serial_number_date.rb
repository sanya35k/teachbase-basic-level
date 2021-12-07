# frozen_string_literal: true

class FindSerialNumberDate
  puts 'Enter the day:'
  day = gets.chomp.to_i
  puts 'Enter the month:'
  month = gets.chomp.to_i
  puts 'Enter the year:'
  year = gets.chomp.to_i

  days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

  days[1] = 29 if ((year % 4).zero? && (year % 100).nonzero?) || (year % 400).zero?

  serial_number_date = 0
  (0..month - 1).each { |month_index| serial_number_date += days[month_index] }
  serial_number_date -= days[month - 1] - day

  p serial_number_date
end
