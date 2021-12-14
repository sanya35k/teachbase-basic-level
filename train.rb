# frozen_string_literal: true

require_relative 'company'

class Train
  include Company

  @instances = {}

  attr_reader :number, :carriages, :speed, :route, :current_station_index

  def initialize(number)
    @number = number
    @carriages = []

    @speed = 0
    @route = nil
    @current_station_index = 0

    instances_number_nil_exception
  end

  def instances_number_nil_exception
    begin exc = instances[number].nil?
    rescue StandardError
      return nil
    end

    return unless exc

    instances[number] = self
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

  def instances
    self.class.instances
  end

  class << self
    attr_reader :instances

    def all
      instances
    end

    def find(number)
      instances[number]
    end
  end

  private

  attr_writer :speed, :route, :current_station_index, :carriages
end
