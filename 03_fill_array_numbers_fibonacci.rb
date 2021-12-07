# frozen_string_literal: true

class FillArrayNumbersFibonacci
  array = [1, 1]
  num_fib = array[-1] + array[-2]
  while num_fib < 100
    array << num_fib
    num_fib = array[-1] + array[-2]
  end
  puts array
end
