# frozen_string_literal: true

class CargoCarriage < Carriage
  attr_accessor :total_volume, :busy_volume

  validate :total_volume, :presence
  validate :total_volume, :type, Integer

  def initialize(company_name, total_volume)
    @total_volume = total_volume
    @busy_volume = 0
    super(company_name)
  end

  def type
    :cargo
  end

  def info
    "Type: #{type}"
  end

  def add_volume_cargo(volume)
    @busy_volume += volume if @total_volume - volume >= @busy_volume
  end

  def busy_value_volume
    @busy_volume
  end

  def free_value_volume
    @total_volume - @busy_volume
  end
end
