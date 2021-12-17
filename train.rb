# frozen_string_literal: true

require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'

class Train
  include Company
  include InstanceCounter
  include Validation

  attr_reader :number, :carriages, :speed, :route, :current_station_index

  TRAIN_NUMBER_FORMAT = /^[A-Z\d](-[a-z\d]{2})?$/i.freeze

  def initialize(number, type = :cargo)
    @number = number
    @carriages = []

    @speed = 0
    @route = nil
    @current_station_index = 0

    register_instance

    validate!
    @type = type
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

  def validate!
    raise ArgumentError, 'Train name not specified!' if @number.nil?
    raise ArgumentError, "Invalid number of carriage!('A-12' or 'B-fa')" unless @number =~ TRAIN_NUMBER_FORMAT
  end

  private

  attr_writer :speed, :route, :current_station_index, :carriages
end
