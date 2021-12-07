# frozen_string_literal: true

class FillHashVowelsLetters
  vowels = %w[a e i o u y]
  hash = {}
  ('a'..'z').each_with_index do |k, v|
    vowels.include?(k) && hash[k.to_s] = v + 1
  end
  puts hash
end
