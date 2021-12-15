# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  @all_stations = []

  def initialize(name)
    @name = name
    @trains = []

    register_instance

    validate!
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

  def validate!
    raise ArgumentError, 'Station name not specified!' if @name.nil?
    raise ArgumentError, 'Station name cannot be empty!' if @name.empty?
    raise ArgumentError, 'Station name cannot start with a space!' if @name[0] == ' '
  end

  private

  attr_writer :trains
end
