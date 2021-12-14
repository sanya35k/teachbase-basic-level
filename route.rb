# frozen_string_literal: true

class Route
  attr_reader :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
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

  private

  attr_writer :stations
end
