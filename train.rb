# frozen_string_literal: true

class Train
  attr_reader :number, :type, :carriages, :speed, :route, :current_station_index

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []

    @speed = 0
    @route = nil
    @current_station_index = 0
  end

  def acceleration(value)
    self.speed += value if value.positive?
  end

  def deceleration(value)
    self.speed -= value if value <= @speed.positive?
  end

  def add_carriage(carriage)
    carriages << carriage if speed.zero?
  end

  def remove_carriage(carriage)
    carriages.delete_at(-1) if speed.zero? && carriage.positive?
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
end
