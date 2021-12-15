# frozen_string_literal: true

require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  @all_stations = []

  def initialize(name)
    @name = name
    @trains = []

    @all_stations.push(self)
    register_instance
  end

  def add_train(train)
    trains << train
  end

  def trains_list
    trains.map(&:number).join
  end

  def trains_list_by_type(type)
    trains.select { |k| k.type == type }.join(' ')
  end

  def remove_train(train)
    trains.delete(train)
  end

  def each_train(&block)
    trains.each { |train| block.call(train) }
  end

  def self.all
    @all_stations
  end

  private

  attr_writer :trains
end
