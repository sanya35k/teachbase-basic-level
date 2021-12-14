# frozen_string_literal: true

class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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

  def each_train
    trains.each { |train| yield(train) }
  end

  private

  attr_writer :trains
end
