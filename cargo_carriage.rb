# frozen_string_literal: true

class CargoCarriage < Carriage
  def type
    :cargo
  end

  def info
    "Type: #{type}"
  end
end
