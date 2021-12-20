# frozen_string_literal: true

class PassengerCarriage < Carriage
  attr_reader :total_seats, :busy_seats

  validate :total_seats, :presence
  validate :total_seats, :type, Integer

  def initialize(company_name, total_seats)
    @total_seats = total_seats
    @busy_seats = 0
    super(company_name)
  end

  def type
    :passenger
  end

  def info
    "Type: #{type}"
  end

  def add_seat_passengers
    @busy_seats += 1 if @busy_seats < @total_seats
  end

  def busy_seats_passengers
    @busy_seats
  end

  def free_seats_passengers
    @total_seats - @busy_seats
  end

  protected

  attr_writer :busy_seats
end
