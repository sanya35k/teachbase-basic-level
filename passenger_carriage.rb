# frozen_string_literal: true

class PassengerCarriage < Carriage
  def type
    :passenger
  end

  def info
    "Type: #{type}"
  end
end
