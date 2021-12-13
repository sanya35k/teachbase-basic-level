# frozen_string_literal: true

class Station
  attr_reader :name, :trains, :instances

  @instances = []

  def initialize(name)
    @name = name
    @trains = []

    instances << self
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

  def self.all
    instances
  end

  private

  attr_writer :trains
end
