# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'

class Train
  include Company
  include InstanceCounter

  attr_reader :number, :carriages, :speed, :route, :current_station_index

  def initialize(number)
    @number = number
    @carriages = []

    @speed = 0
    @route = nil
    @current_station_index = 0

    register_instance
  end

  def acceleration(value)
    self.speed += value if value.positive?
  end

  def deceleration(value)
    self.speed -= value if value <= @speed.positive?
  end

  def current_carriages(carriage)
    carriages[carriage]
  end

  def add_carriage(carriage)
    carriages << carriage if speed.zero? && carriage.type == type
  end

  def remove_carriage
    carriages.delete_at(-1) if speed.zero?
  end

  def add_route(route)
    self.route += route
  end

  def current_station
    route.stations[current_station_index]
  end

  def next_station
    route.stations[current_station_index + 1]
  end

  def previous_station
    route.stations[current_station_index - 1] if current_station_index >= 1
  end

  def each_carriage(&block)
    carriages.each { |carriage| block.call(carriage) }
  end

  def type
    raise 'For future overriding...'
  end

  private

  attr_writer :speed, :route, :current_station_index, :carriages
end
