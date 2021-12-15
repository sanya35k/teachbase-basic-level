# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations, :first_station, :last_station

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @first_station = first_station
    @last_station = last_station

    register_instance

    validate!
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def remove_station(station)
    stations.delete(station)
  end

  def stations_list
    puts stations.map(&:name)
  end

  def validate!
    raise ArgumentError, 'Route parameter must be a station!' if @stations.find { |s| s.class != Station }
    raise ArgumentError, 'First and last stations must be different!' if first_station == last_station
  end

  private

  attr_writer :stations
end
